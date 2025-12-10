{ builder, ... }:
let
  atlassianFolder = { title = "Atlassian"; uuid = "f554887d-ce01-4f08-9174-6f41710a838a"; };
  atlassian = builder.mkFolderBuilder atlassianFolder;
  hrFolder = { title = "HR"; uuid = "dccbad97-b665-425a-a8be-25e248dcb556"; };
  hr = builder.mkFolderBuilder hrFolder;
in
{
  uuid = "77597019-492d-4ffd-ad3a-a5232f0b86cf";
  spaceIcon = "🏒";
  key = "Work";
  color = "blue";
  icon = "briefcase";
  id = 2;
  theme = [
    { red = 127; green = 162; blue = 230; custom = false; algorithm = "floating"; primary = true; lightness = 70; position = { x = 134; y = 142; }; type = "explicit-lightness"; }
  ];
  folders = [ atlassianFolder hrFolder ];
  pins = [
    { title = "Microsoft Apps"; url = "https://myapps.microsoft.com"; uuid = "6d85b089-df5f-47ca-a56f-40db18bc4351"; }
  ] ++ (atlassian [
    { title = "Atlassian"; url = "https://home.atlassian.com/"; uuid = "e85c4e54-ae5e-45ed-84f1-742d5525ede5"; }
    { title = "Confluence"; url = "https://thescore.atlassian.net/wiki/home"; uuid = "e03136a5-ca51-4be9-8438-e1e5105998bd"; }
    { title = "Jira"; url = "https://thescore.atlassian.net/jira"; uuid = "b3cccda2-184c-40aa-b832-25c2105f7302"; }
  ]) ++ (hr [
    { title = "UKG"; url = "https://pngaming.ultipro.com"; uuid = "7703144c-2af6-4fe8-b726-92c26aa50066"; }
    { title = "Canadian UKG"; url = "https://secure60.saashr.com/ta/6176628.login"; uuid = "1503e528-bfd3-4c58-966e-9946a4fa7a06"; }
    { title = "Dayforce"; url = "https://us252.dayforcehcm.com"; uuid = "7e531580-0abc-4fe5-a46a-42c648accc10"; }
  ]);
}
