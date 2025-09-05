{ config, lib, username, ... }: {
  options = {
    mods.zed = {
      enable = lib.mkEnableOption "Enables Zed Editor";
    };
  };
  config = lib.mkIf config.mods.zed.enable {
    home-manager.users.${username} = {
      programs.zed-editor = {
        enable = true;
        extensions = ["nix" "toml" "elixir" "make"];
        userSettings = {
          vim_mode = true;
          show_whitespace = "all";
        };
      };
    };
  };
}
