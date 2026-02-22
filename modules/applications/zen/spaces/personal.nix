{ builder }:
{
  uuid = "ec9acdc5-c69a-496a-a7ac-7ca230537214";
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
    {
      title = "GitHub";
      url = "https://github.com";
      isEssential = true;
      uuid = "6bc71f4c-44ae-40bd-95b9-b71d549bd13b";
    }
    {
      title = "Reddit";
      url = "https://reddit.com";
      isEssential = true;
      uuid = "f92d1281-77f2-4b6e-9ada-7c1bee3d87bc";
    }
    {
      title = "Plex";
      url = "https://app.plex.tv";
      uuid = "1efbc2d2-0ec0-428e-8a65-40cc850caaff";
    }
    {
      title = "Samply";
      url = "https://samply.app";
      uuid = "aab3185c-423b-445e-b09c-4466f7890917";
    }
  ]
  ++ (builder.mkFolder {
    title = "Finance";
    uuid = "bdb2d5f1-2199-42f7-bef4-7775c4374869";
    sites = [
      {
        title = "AccesD";
        url = "https://accweb.mouv.desjardins.com/identifiantunique/securite-garantie/authentification/auth/manuel";
        uuid = "2a58e498-1914-49e8-94e8-4a97d9325bbd";
      }
      {
        title = "BNC";
        url = "https://app.bnc.ca/?lang=fr";
        uuid = "464321ea-ff5a-47c1-9178-110a46330754";
      }
      {
        title = "Wealthsimple";
        url = "https://my.wealthsimple.com/app/login?locale=en-ca";
        uuid = "204a6c43-7ecd-4ba3-bdc1-a8ad5691d583";
      }
    ];
  })
  ++ (builder.mkFolder {
    title = "Social";
    uuid = "efe985a2-0491-48c2-97f6-0e850235b636";
    sites = [
      {
        title = "Facebook";
        url = "https://facebook.com";
        uuid = "ab183d96-1996-4257-a283-f3b0ce55b1ac";
      }
      {
        title = "Messenger";
        url = "https://messenger.com";
        uuid = "d489a983-907e-4881-850b-eaeaac4b7808";
      }
      {
        title = "Slack";
        url = "https://slack.com";
        uuid = "a784a659-6026-4cc2-98f5-497b8c9f5ac0";
      }
      {
        title = "YouTube";
        url = "https://youtube.com";
        uuid = "9a75eb64-47cb-4f51-8b56-b1e20c60eabd";
      }
    ];
  });
}
