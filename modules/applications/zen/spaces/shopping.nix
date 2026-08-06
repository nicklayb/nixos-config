{ builder, ... }:
{
  spaceIcon = "💸";
  key = "Shopping";
  color = "yellow";
  icon = "cart";
  id = 3;
  theme = [
    {
      red = 104;
      green = 202;
      blue = 150;
      custom = false;
      algorithm = "floating";
      primary = true;
      lightness = 255;
      position = {
        x = 100;
        y = 231;
      };
      type = "explicit-lightness";
    }
  ];
  pins = [
    (builder.mkPin {
      title = "Aliexpress";
      url = "https://aliexpress.com";
    })
    (builder.mkPin {
      title = "Amazon";
      url = "https://amazon.ca";
    })
    (builder.mkPin {
      title = "Apple";
      url = "https://apple.ca/store";
    })
    (builder.mkPin {
      title = "eBay";
      url = "https://ebay.ca";
    })
    (builder.mkPin {
      title = "Kickstarter";
      url = "https://kickstarter.com";
    })
    (builder.mkPin {
      title = "Newegg";
      url = "https://newegg.ca";
    })
    (builder.mkPin {
      title = "Reverb";
      url = "https://reverb.com";
    })
  ];
}
