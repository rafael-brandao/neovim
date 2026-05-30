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
            run pkg=("default"):
              nix run .#{{pkg}}

            # Inspect a neovim package: just inspect nvf | just inspect nvf-dev
            [arg("pkg", pattern="^(default|nvf|nvf-dev)$")]
            inspect pkg=("default"):
              nix build .#{{pkg}}
              ./result/bin/nvf-print-config | bat --language lua

            [group: 'shorthands']
            nvf:
              just run nvf

            [group: 'shorthands']
            nvf-dev:
              just run nvf-dev
          '';
      };
    };
  };
}
