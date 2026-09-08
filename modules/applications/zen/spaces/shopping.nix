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
    (builder.pin "Aliexpress" "https://aliexpress.com")
    (builder.pin "Amazon" "https://amazon.ca")
    (builder.pin "Apple" "https://apple.ca/store")
    (builder.pin "eBay" "https://ebay.ca")
    (builder.pin "Kickstarter" "https://kickstarter.com")
    (builder.pin "Newegg" "https://newegg.ca")
    (builder.pin "Reverb" "https://reverb.com")
  ];
}
