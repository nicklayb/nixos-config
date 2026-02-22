{ ... }:
{
  imports = [
    ./applications
    ./bluetooth
    ./bundles
    ./command_line
    ./desktop_environment
    ./dev
    ./docker
    ./fonts
    ./inputs
    ./locale
    ./services
    ./virtualization
  ];

  xdg.mime.defaultApplications =
    let
      browser = "zen-twilight.desktop";
    in
    {
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
    };
}
