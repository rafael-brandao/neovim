{inputs, ...}: {
  imports = [inputs.just-flake.flakeModule];

  perSystem = _: {
    just-flake.features = {
      convco.enable = true;
      treefmt.enable = true;
      custom = {
        enable = true;
        justfile =
          # just
          ''
            # Run a neovim package: just run nvf | just run nvf-dev
            [arg("pkg", pattern="^(default|nvf|nvf-dev)$")]
            run pkg=("default") *args:
              nix run .#{{pkg}} {{args}}
            
            # Inspect a neovim package: just inspect nvf | just inspect nvf-dev
            [arg("pkg", pattern="^(default|nvf|nvf-dev)$")]
            inspect pkg=("default") *args:
              nix build .#{{pkg}} {{args}}
              ./result/bin/nvf-print-config | bat --language lua
            
            [group: 'shorthands']
            nvf *args:
              just run nvf {{args}}
            
            [group: 'shorthands']
            nvf-dev *args:
              just run nvf-dev {{args}}
          '';
      };
    };
  };
}
