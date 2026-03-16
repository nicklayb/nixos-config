# Custom zen configuration

## Evaluating in repl

```
:r # Reload if changes were made since
:lf ./ # Loads flake
box = import ./box.nix {} # Imports local box
zen = import ./modules/applications/zen/spaces/default.nix { lib = inputs.nixpkgs.lib; box = box; }
```
