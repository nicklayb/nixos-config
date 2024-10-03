{ pkgs, mainUser, ... }: {
  services.gnome.gnome-keyring.enable = true;

  home-manager.users.${mainUser.username} = {
    services.gnome-keyring.enable = true;
  };
}
