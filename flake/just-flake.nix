{inputs, ...}: {
  imports = [inputs.just-flake.flakeModule];

  perSystem = _: {
    just-flake.features = {
      convco.enable = true;
      treefmt.enable = true;
      custom = {
        enable = true;
        justfile = ''
          # Run a neovim package: just run nvf | just run nvf dev
          [arg("pkg", pattern="^(nvf)$")]
          [arg("variant", pattern="^(default|dev)$")]
          run pkg variant=("default"):
            nix run .#rb.{{pkg}}.{{variant}}

          # Inspect a neovim package: just inspect nvf | just inspect nvf dev
          [arg("pkg", pattern="^(nvf)$")]
          [arg("variant", pattern="^(default|dev)$")]
          inspect pkg variant=("default"):
            nix build .#rb.{{pkg}}.{{variant}}
            result/bin/nvf-print-config | bat --language lua

          [group: 'shorthands']
          nvf:
            just run nvf

          [group: 'shorthands']
          nvf-dev:
            just run nvf dev
        '';
      };
    };
  };
}
