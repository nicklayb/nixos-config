{ }:

let
  uuidv5 =
    namespace: value:
    let
      hash = builtins.hashString "sha1" (namespace + value);
      hex = hash; # hash déjà en hex
    in
    builtins.concatStringsSep "-" [
      (builtins.substring 0 8 hex)
      (builtins.substring 8 4 hex)
      (builtins.substring 12 4 hex)
      (builtins.substring 16 4 hex)
      (builtins.substring 20 12 hex)
    ];
in
{
  inherit uuidv5;
}
