{ users, pkgs }: 
let
  users = map ({ user } : {
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
