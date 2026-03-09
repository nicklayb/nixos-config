{ builder, ... }:
{
  spaceIcon = "🏒";
  key = "Work";
  color = "blue";
  icon = "briefcase";
  id = 2;
  theme = [
    {
      red = 127;
      green = 162;
      blue = 230;
      custom = false;
      algorithm = "floating";
      primary = true;
      lightness = 70;
      position = {
        x = 134;
        y = 142;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.mkPin {
      title = "Microsoft Apps";
      url = "https://myapps.microsoft.com";
    })
  ]
  ++ (builder.mkFolder {
    title = "Atlassian";
    sites = [
      (builder.mkPin {
        title = "Atlassian";
        url = "https://home.atlassian.com/";
      })
      (builder.mkPin {
        title = "Confluence";
        url = "https://thescore.atlassian.net/wiki/home";
      })
      (builder.mkPin {
        title = "Jira";
        url = "https://thescore.atlassian.net/jira";
      })
      (builder.mkPin {
        title = "Roadmap";
        url = "https://thescore.atlassian.net/jira/polaris/projects/KP/ideas/view/8840709";
      })
    ];
  })
  ++ (builder.mkFolder {
    title = "HR";
    sites = [
      (builder.mkPin {
        title = "UKG";
        url = "https://pngaming.ultipro.com";
      })
      (builder.mkPin {
        title = "Canadian UKG";
        url = "https://secure60.saashr.com/ta/6176628.login";
      })
      (builder.mkPin {
        title = "Dayforce";
        url = "https://us252.dayforcehcm.com";
      })
    ];
  });
}
