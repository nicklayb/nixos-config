# Custom zen configuration

## Evaluating in repl

```
:r # Reload if changes were made since
:lf ./ # Loads flake
utils = import ./box.nix {} # Imports local utils
zen = import ./modules/applications/zen/spaces/default.nix { lib = inputs.nixpkgs.lib; utils = utils; }
```
