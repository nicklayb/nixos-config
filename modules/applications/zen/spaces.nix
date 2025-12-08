{ lib, ... }: let
  builder = import ./builder.nix { lib = lib; };
  hexdocFolder = { title = "Hexdocs"; uuid = "7530ffe6-08cf-428e-9c3c-0782af1afd55"; };
  hexdoc = sites: builder.multiPins { 
    title = "Hexdocs"; 
    baseUrl = path : "https://hexdocs.pm/${path}";
    folderId = hexdocFolder.uuid;
    sites = sites;
  };
  personal = {
    uuid = "ec9acdc5-c69a-496a-a7ac-7ca230537214";
    spaceIcon = "🏠";
    key = "Personal";
    color = "purple";
    icon = "pet";
    id = 1;
  };
  work = {
    uuid = "77597019-492d-4ffd-ad3a-a5232f0b86cf";
    spaceIcon = "🏒";
    key = "Work";
    color = "blue";
    icon = "briefcase";
    id = 2;
  };
  shopping = {
    uuid = "0eeb858e-5f70-4e29-8a9c-d69a2b1e447b";
    spaceIcon = "💸";
    key = "Shopping";
    color = "yellow";
    icon = "cart";
    id = 3;
  };
  dev = {
    key = "Dev";
    uuid = "0d38b887-831a-42e7-8ee2-21aaa04fdf14";
    spaceIcon = "👓";
    color = "pink";
    icon = "fingerprint";
    id = 4;
    folders = [hexdocFolder];
    pins = [
      {
        title = "Nixpkgs";
        uuid = "79862301-ec33-4c0d-8b7e-88ea1715643d";
        url = "https://search.nixos.org/packages";
      }
    ] ++ (hexdoc [
      { title = "Phoenix Live View"; url = "phoenix_live_view"; uuid = "3b41e401-a7a3-418d-912f-0facbe622cd9"; }
      { title = "Phoenix"; url = "phoenix"; uuid = "7a390e3f-29ea-4092-b8f5-5ebaefc6cd62"; }
      { title = "Ecto"; url = "ecto"; uuid = "70ff468b-3cb7-4dc3-a5f8-42e266618317"; }
      { title = "Oban"; url = "oban"; uuid = "08d0dffc-10bb-48fd-819f-414a22c913ee"; }
    ]);
  };
  all = [ personal shopping dev work ];
in {
  containers = builder.toContainers all;
  spaces = builder.toSpaces all;
  pins = builder.toPins all;
}
