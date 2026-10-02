{ builder }:
{
  spaceIcon = "🏠";
  key = "Personal";
  color = "purple";
  icon = "pet";
  id = 1;
  theme = [
    {
      red = 222;
      green = 166;
      blue = 242;
      custom = false;
      algorithm = "complementary";
      primary = false;
      lightness = 255;
      position = {
        x = 192;
        y = 137;
      };
      type = "explicit-lightness";
    }
    {
      red = 164;
      green = 244;
      blue = 204;
      custom = false;
      algorithm = "complementary";
      primary = false;
      lightness = 80;
      position = {
        x = 146;
        y = 201;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.essential "GitHub" "https://github.com")
    (builder.essential "Reddit" "https://reddit.com")

    (builder.pin "GitLab" "https://gitlab.com")
    (builder.pin "Plex" "https://app.plex.tv")
    (builder.pin "Samply" "https://samply.app")
    (builder.pin "YouTube" "https://youtube.com")
    (builder.pin "Patreon" "https://patreon.com")
  ]
  ++ (builder.mkFolder {
    title = "Finance";
    sites = [
      (builder.pin "AccesD" "https://accweb.mouv.desjardins.com/identifiantunique/securite-garantie/authentification/auth/manuel")
      (builder.pin "BNC" "https://app.bnc.ca/?lang=fr")
      (builder.pin "Wealthsimple" "https://my.wealthsimple.com/app/login?locale=en-ca")
    ];
  })
  ++ (builder.mkFolder {
    title = "Social";
    sites = [
      (builder.pin "Facebook" "https://facebook.com")
      (builder.pin "Messenger" "https://messenger.com")
      (builder.pin "Slack" "https://slack.com")
    ];
  })
  ++ (builder.mkFolder {
    title = "AI";
    sites = [
      (builder.pin "ChatGPT" "https://chatgpt.com")
      (builder.pin "Claude" "https://claude.ai")
    ];
  })
  ++ (builder.mkFolder {
    title = "Tools";
    sites = [
      (builder.pin "TinkerCAD" "https://tinkercad.com")
      (builder.pin "Gridfinity Layout Tool" "https://gridfinitylayouttool.com")
      (builder.pin "Photopea" "https://photopea.com")
      (builder.pin "JLCPCB" "https://jlcpcb.com")
    ];
  })
  ++ (builder.mkFolder {
    title = "Home lab";
    sites = [
      (builder.pin "OPNSense" "http://192.168.1.1")
      (builder.pin "Grafana" "http://monitor.nboisvert.local:3000")
      (builder.pin "Adguard" "http://adguard.nboisvert.local")
      (builder.pin "Proxmox" "https://jekyll.nboisvert.local:8006")
    ];
  });
}
