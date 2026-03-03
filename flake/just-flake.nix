{inputs, ...}: {
  imports = [inputs.just-flake.flakeModule];

  perSystem = _: {
    just-flake.features = {
      convco.enable = true;
      treefmt.enable = true;
      custom = {
        enable = true;
        justfile = ''
          # Run one of [ nvf, nvf-dev ]
          [arg("dist", pattern="^(nvf|nvf-dev)$")]
          run dist:
            nix run .#{{dist}}

          # Inspect one of [ nvf, nvf-dev ]
          [arg("dist", pattern="^(nvf|nvf-dev)$")]
          inspect dist:
            nix build .#{{dist}} && result/bin/nvf-print-config | bat --language lua

          
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
