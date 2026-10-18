# Manage OPNsense Unbound host overrides interactively through opn-api.

readonly device="${OPN_API_DEVICE:-default}"
readonly api_path="unbound/settings"
readonly record_types=("A" "AAAA" "MX")
readonly all_rows=-1

# Prints usage information.
print_usage() {
  cat <<EOF
Usage: unbound-hosts <command> [options]

Commands:
  list [--search TEXT]  List host overrides, optionally filtered
  create                Create a host override from prompts
  edit                  Pick a host override with fzf and edit it
  delete                Pick a host override with fzf and delete it

Environment:
  OPN_API_DEVICE        opn-api device name (default: "default")
EOF
}

# Calls the OPNsense API through opn-api with JSON output.
# Arguments: HTTP method (get|post), API path, optional JSON body.
call_api() {
  opn-api --device "$device" --format json "$@"
}

# Prints host overrides as JSON rows matching the given search phrase.
search_overrides() {
  local search_phrase="$1"
  local body
  body=$(jq --null-input --compact-output \
    --arg search_phrase "$search_phrase" --argjson row_count "$all_rows" \
    '{current: 1, rowCount: $row_count, searchPhrase: $search_phrase}')
  call_api post "$api_path/searchHostOverride" "$body" | jq --compact-output '.rows[]'
}

# Prints host override rows as tab separated lines: uuid, fqdn, type, target, description.
format_overrides() {
  jq --raw-output '[
      .uuid,
      ([.hostname, .domain] | map(select(. != "")) | join(".")),
      (.rr | split(" ")[0]),
      (if .server != "" then .server else "\(.mxprio) \(.mx)" end),
      .description
    ] | @tsv'
}

# Lists host overrides as a table, filtered by an optional --search option.
command_list() {
  local search_phrase=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --search)
        search_phrase="${2:?--search requires a value}"
        shift 2
        ;;
      *)
        echo "Unknown option: $1" >&2
        return 1
        ;;
    esac
  done

  {
    printf 'HOST\tTYPE\tTARGET\tDESCRIPTION\n'
    search_overrides "$search_phrase" | format_overrides | cut --fields=2-
  } | column --table --separator=$'\t'
}

# Lets the user pick a host override with fzf and prints its uuid.
select_override_uuid() {
  local selection
  selection=$(search_overrides "" | format_overrides |
    fzf --delimiter=$'\t' --with-nth=2.. --prompt="Host override> ") || return 1
  cut --fields=1 <<<"$selection"
}

# Prompts for a value with an editable default. Arguments: label, default value.
prompt_field() {
  local label="$1"
  local default_value="$2"
  local value
  read -r -e -p "$label: " -i "$default_value" value
  printf '%s' "$value"
}

# Prompts for a record type with fzf. Argument: currently selected type.
prompt_record_type() {
  local current_type="$1"
  printf '%s\n' "${record_types[@]}" |
    fzf --prompt="Record type> " --query="$current_type" --select-1 --height=~10
}

# Prompts for a yes/no answer and prints 1 or 0. Arguments: label, default (1 or 0).
prompt_enabled() {
  local default_value="$1"
  local default_answer="n"
  [[ "$default_value" == "1" ]] && default_answer="y"
  local answer
  answer=$(prompt_field "Enabled (y/n)" "$default_answer")
  if [[ "$answer" =~ ^[Yy] ]]; then printf '1'; else printf '0'; fi
}

# Prints a string field of a JSON object, or an empty string. Arguments: JSON object, field name.
json_field() {
  jq --raw-output --arg field "$2" '.[$field] // ""' <<<"$1"
}

# Prompts for every host override field, using the given JSON object as defaults.
# Prints the request body expected by OPNsense.
prompt_override() {
  local defaults="$1"

  local enabled hostname domain record_type server mx_priority mx description
  enabled=$(prompt_enabled "$(json_field "$defaults" enabled)")
  hostname=$(prompt_field "Hostname (empty for wildcard)" "$(json_field "$defaults" hostname)")
  domain=$(prompt_field "Domain" "$(json_field "$defaults" domain)")
  record_type=$(prompt_record_type "$(json_field "$defaults" rr)") || return 1
  echo "Record type: $record_type" >&2
  if [[ "$record_type" == "MX" ]]; then
    mx_priority=$(prompt_field "MX priority" "$(json_field "$defaults" mxprio)")
    mx=$(prompt_field "MX host" "$(json_field "$defaults" mx)")
  else
    server=$(prompt_field "IP address" "$(json_field "$defaults" server)")
  fi
  description=$(prompt_field "Description" "$(json_field "$defaults" description)")

  jq --null-input --compact-output \
    --arg enabled "$enabled" --arg hostname "$hostname" --arg domain "$domain" \
    --arg rr "$record_type" --arg server "${server:-}" --arg mxprio "${mx_priority:-}" \
    --arg mx "${mx:-}" --arg description "$description" \
    '{host: {enabled: $enabled, hostname: $hostname, domain: $domain, rr: $rr,
             server: $server, mxprio: $mxprio, mx: $mx, description: $description}}'
}

# Prints a host override as a flat JSON object, resolving the selected record type.
fetch_override() {
  local uuid="$1"
  call_api get "$api_path/getHostOverride/$uuid" |
    jq --compact-output '.host | .rr = (.rr | to_entries[] | select(.value.selected == 1) | .key)'
}

# Applies pending changes to the running Unbound service.
apply_changes() {
  call_api post "unbound/service/reconfigure" '{}' >/dev/null
  echo "Unbound reconfigured." >&2
}

# Creates a host override from prompts.
command_create() {
  local body
  body=$(prompt_override '{"enabled": "1"}') || return 1
  call_api post "$api_path/addHostOverride" "$body"
  apply_changes
}

# Edits a host override picked with fzf.
command_edit() {
  local uuid body
  uuid=$(select_override_uuid) || return 1
  body=$(prompt_override "$(fetch_override "$uuid")") || return 1
  call_api post "$api_path/setHostOverride/$uuid" "$body"
  apply_changes
}

# Deletes a host override picked with fzf.
command_delete() {
  local uuid
  uuid=$(select_override_uuid) || return 1
  call_api post "$api_path/delHostOverride/$uuid" '{}'
  apply_changes
}

main() {
  local command="${1:-}"
  shift || true
  case "$command" in
    list) command_list "$@" ;;
    create) command_create ;;
    edit) command_edit ;;
    delete) command_delete ;;
    *)
      print_usage
      [[ "$command" == "-h" || "$command" == "--help" ]]
      ;;
  esac
}

main "$@"
