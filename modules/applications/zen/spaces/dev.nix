{ builder }: {
  key = "Dev";
  uuid = "0d38b887-831a-42e7-8ee2-21aaa04fdf14";
  spaceIcon = "👓";
  color = "pink";
  icon = "fingerprint";
  id = 4;
  theme = [
    { algorithm = "analogous"; red = 231; green = 233; blue = 124; lightness = 70; position = { x = 206; y = 227; }; type = "explicit-lightness"; }
    { algorithm = "analogous"; red = 128; green = 229; blue = 130; lightness = 70; position = { x = 148; y = 235; }; type = "explicit-lightness"; }
    { algorithm = "analogous"; red = 232; green = 125; blue = 131; lightness = 70; position = { x = 237; y = 178; }; type = "explicit-lightness"; }
  ];
  pins = [
    {
      title = "Nixpkgs";
      uuid = "79862301-ec33-4c0d-8b7e-88ea1715643d";
      url = "https://search.nixos.org/packages";
    }
  ] ++ (builder.mkFolder {
    title = "Hexdocs";
    baseUrl = path : "https://hexdocs.pm/${path}";
    uuid = "7530ffe6-08cf-428e-9c3c-0782af1afd55";
    sites = [
      { title = "Phoenix Live View"; url = "phoenix_live_view"; uuid = "3b41e401-a7a3-418d-912f-0facbe622cd9"; }
      { title = "Phoenix"; url = "phoenix"; uuid = "7a390e3f-29ea-4092-b8f5-5ebaefc6cd62"; }
      { title = "Ecto"; url = "ecto"; uuid = "70ff468b-3cb7-4dc3-a5f8-42e266618317"; }
      { title = "Oban"; url = "oban"; uuid = "08d0dffc-10bb-48fd-819f-414a22c913ee"; }
    ];
  }) ++ (builder.mkFolder {
    title = "Elm";
    uuid = "186c2406-2dab-41e4-8bc6-c62434bfef44";
    baseUrl = path : "https://package.elm-lang.org/packages/${path}";
    sites = [
      { url = "elm/core"; uuid = "a767f5b7-2fe3-451e-85ba-1b84f6044171"; }
      { url = "elm/json"; uuid = "680b97d0-fc1c-47b5-9197-c8ba097778e6"; }
      { url = "elm/html"; uuid = "2d714399-68d4-423e-bfd7-9e2160216a56"; }
      { url = "elm/http"; uuid = "a767f5b7-2fe3-451e-85ba-1b84f6044171"; }
    ];
  });
}
