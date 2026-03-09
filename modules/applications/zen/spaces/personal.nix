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
      lightness = 80;
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
    (builder.mkPin {
      title = "GitHub";
      url = "https://github.com";
      isEssential = true;
    })
    (builder.mkPin {
      title = "Reddit";
      url = "https://reddit.com";
      isEssential = true;
    })
    (builder.mkPin {
      title = "Plex";
      url = "https://app.plex.tv";
    })
    (builder.mkPin {
      title = "Samply";
      url = "https://samply.app";
    })
  ]
  ++ (builder.mkFolder {
    title = "Finance";
    sites = [
      (builder.mkPin {
        title = "AccesD";
        url = "https://accweb.mouv.desjardins.com/identifiantunique/securite-garantie/authentification/auth/manuel";
      })
      (builder.mkPin {
        title = "BNC";
        url = "https://app.bnc.ca/?lang=fr";
      })
      (builder.mkPin {
        title = "Wealthsimple";
        url = "https://my.wealthsimple.com/app/login?locale=en-ca";
      })
    ];
  })
  ++ (builder.mkFolder {
    title = "Social";
    sites = [
      (builder.mkPin {
        title = "Facebook";
        url = "https://facebook.com";
      })
      (builder.mkPin {
        title = "Messenger";
        url = "https://messenger.com";
      })
      (builder.mkPin {
        title = "Slack";
        url = "https://slack.com";
      })
      (builder.mkPin {
        title = "YouTube";
        url = "https://youtube.com";
      })
    ];
  });
}
