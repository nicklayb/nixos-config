{ builder }:
{
  key = "Dev";
  spaceIcon = "👓";
  color = "pink";
  icon = "fingerprint";
  id = 4;
  theme = [
    {
      algorithm = "analogous";
      red = 231;
      green = 233;
      blue = 124;
      lightness = 70;
      position = {
        x = 206;
        y = 227;
      };
      type = "explicit-lightness";
    }
    {
      algorithm = "analogous";
      red = 128;
      green = 229;
      blue = 130;
      lightness = 70;
      position = {
        x = 148;
        y = 235;
      };
      type = "explicit-lightness";
    }
    {
      algorithm = "analogous";
      red = 232;
      green = 125;
      blue = 131;
      lightness = 255;
      position = {
        x = 237;
        y = 178;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.pin "Nixpkgs" "https://search.nixos.org/packages")
    (builder.pin "Tailwind CSS" "https://tailwindcss.com/")
  ]
  ++ (builder.mkFolder {
    title = "Nix";
    sites = [
      (builder.pin "NixOS Option Types" "https://nlewo.github.io/nixos-manual-sphinx/development/option-types.xml.html")
      (builder.pin "Home Manager" "https://nix-community.github.io/home-manager/")
    ];
  })
  ++ (builder.mkFolder {
    title = "Hexdocs";
    baseUrl = path: "https://hexdocs.pm/${path}";
    sites = [
      (builder.pin "Elixir" "")
      (builder.pin "Phoenix Live View" "phoenix_live_view")
      (builder.pin "Phoenix" "phoenix")
      (builder.pin "Ecto" "ecto")
      (builder.pin "Oban" "oban")
      (builder.pin "Credo" "credo")
      (builder.pin "Absinthe" "absinthe")
      (builder.pin "Livebook" "livebook")
    ];
  })
  ++ (builder.mkFolder {
    title = "Elm";
    baseUrl = path: "https://package.elm-lang.org/packages/${path}";
    sites = [
      (builder.mkPin {
        url = "elm/core";
      })
      (builder.mkPin {
        url = "elm/json";
      })
      (builder.mkPin {
        url = "elm/html";
      })
      (builder.mkPin {
        url = "elm/http";
      })
    ];
  });
}
