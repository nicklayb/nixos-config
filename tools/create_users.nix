{ users, pkgs }: 
let
  users = builtins.mapAttrs (name: { user } : {
    ${user.username} = {
      isNormalUser = true;
      description = user.name;
      extraGroups = user.groups;
      shell = pkgs.zsh;
    };
  }) users;
in {
  users = users;
}
