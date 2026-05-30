{inputs, ...}: {
  flake = {
    modules = {
      rb.nvf = rec {
        default = [
          {
            _module.args = {inherit (inputs) nvf;};
          }
          ./config
        ];
        dev = default ++ [./dev];
      };
    };

    overlays = {
      rb-nvf = final: prev: let
        inherit (final.stdenv.hostPlatform) system;
      in {
        neovim-nightly = inputs.neovim-nightly.packages.${system}.neovim;

        vimPlugins = with final.vimUtils;
          prev.vimPlugins
          // {
            modes-nvim-git = buildVimPlugin {
              name = "modes.nvim";
              src = inputs.modes-nvim;
              doCheck = false;
            };
            snacks-nvim-git = buildVimPlugin {
              name = "snacks.nvim";
              src = inputs.snacks-nvim;
              doCheck = false;
            };
            tiny-inline-diagnostic-nvim-git = buildVimPlugin {
              name = "tiny-inline-diagnostic.nvim";
              src = inputs.tiny-inline-diagnostic-nvim;
              doCheck = false;
            };
            todo-comments-nvim-git = buildVimPlugin {
              name = "todo-comments.nvim";
              src = inputs.todo-comments-nvim;
              doCheck = false;
            };
            trouble-nvim-git = buildVimPlugin {
              name = "trouble.nvim";
              src = inputs.trouble-nvim;
              doCheck = false;
            };
          };
      };
    };
  };
  perSystem = {pkgs, ...}: let
    mkNvfPkg = modules:
      (inputs.nvf.lib.neovimConfiguration {
        inherit modules pkgs;
      }).neovim;

    packages = with inputs.self.modules; rec {
      default = nvf;
      nvf = mkNvfPkg rb.nvf.default;
      nvf-dev = mkNvfPkg rb.nvf.dev;
    };
  in {
    inherit packages;
  };
}
