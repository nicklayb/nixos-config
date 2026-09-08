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
      lightness = 255;
      position = {
        x = 134;
        y = 142;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.pin "Microsoft Apps" "https://myapps.microsoft.com")
  ]
  ++ (builder.mkFolder {
    title = "Atlassian";
    sites = [
      (builder.pin "Atlassian Home" "https://home.atlassian.com/")
      (builder.pin "Confluence" "https://thescore.atlassian.net/wiki/home")
      (builder.pin "Jira" "https://thescore.atlassian.net/jira")
      (builder.pin "Roadmap" "https://thescore.atlassian.net/jira/polaris/projects/KP/ideas/view/8840709")
    ];
  })
  ++ (builder.mkFolder {
    title = "HR";
    sites = [
      (builder.pin "UKG" "https://pngaming.ultipro.com")
      (builder.pin "Canadian UKG" "https://secure60.saashr.com/ta/6176628.login")
      (builder.pin "Dayforce" "https://us252.dayforcehcm.com")
    ];
  });
}
