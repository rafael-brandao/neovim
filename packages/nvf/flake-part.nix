{inputs, ...}: {
  # flake = {
  #   modules.rb.nvf = ./config;
  # };
  perSystem = {pkgs, ...}: let
    mkNvfPkg = modules:
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules =
          modules
          ++ [
            {
              _module.args = {inherit (inputs) nvf;};
            }
          ];
      }).neovim;
  in {
    packages = {
      nvf = mkNvfPkg [
        ./config
      ];
      nvf-dev = mkNvfPkg [
        ./config
        ./dev
      ];
    };
  };
}
