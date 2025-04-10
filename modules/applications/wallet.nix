{ pkgs, username, ... }: {
  services.gnome.gnome-keyring.enable = true;

  home-manager.users.${username} = {
    services.gnome-keyring.enable = true;
  };
}
