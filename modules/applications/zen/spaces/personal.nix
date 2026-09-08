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
    (builder.pin "Plex" "https://app.plex.tv")
    (builder.pin "Samply" "https://samply.app")
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
      (builder.pin "YouTube" "https://youtube.com")
    ];
  })
  ++ (builder.mkFolder {
    title = "Home lab";
    sites = [
      (builder.pin "Grafana" "http://monitor.nboisvert.local:3000")
    ];
  });
}
