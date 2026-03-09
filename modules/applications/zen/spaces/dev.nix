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
      lightness = 70;
      position = {
        x = 237;
        y = 178;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.mkPin {
      title = "Nixpkgs";
      url = "https://search.nixos.org/packages";
    })
    (builder.mkPin {
      title = "Tailwind CSS";
      url = "https://tailwindcss.com/";
    })
  ]
  ++ (builder.mkFolder {
    title = "Nix";
    sites = [
      (builder.mkPin {
        title = "NixOS Option Types";
        url = "https://nlewo.github.io/nixos-manual-sphinx/development/option-types.xml.html";
      })
      (builder.mkPin {
        title = "Home Manager";
        url = "https://nix-community.github.io/home-manager/";
      })
    ];
  })
  ++ (builder.mkFolder {
    title = "Hexdocs";
    baseUrl = path: "https://hexdocs.pm/${path}";
    sites = [
      (builder.mkPin {
        title = "Elixir";
        url = "";
      })
      (builder.mkPin {
        title = "Phoenix Live View";
        url = "phoenix_live_view";
      })
      (builder.mkPin {
        title = "Phoenix";
        url = "phoenix";
      })
      (builder.mkPin {
        title = "Ecto";
        url = "ecto";
      })
      (builder.mkPin {
        title = "Oban";
        url = "oban";
      })
      (builder.mkPin {
        title = "Credo";
        url = "credo";
      })
      (builder.mkPin {
        title = "Absinthe";
        url = "absinthe";
      })
      (builder.mkPin {
        title = "Livebook";
        url = "livebook";
      })
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
