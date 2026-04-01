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
            blink-cmp-nightly = inputs.blink-cmp.packages.${system}.blink-cmp;

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
  in {
    legacyPackages = {
      rb.nvf = with inputs.self.modules; {
        default = mkNvfPkg rb.nvf.default;
        dev = mkNvfPkg rb.nvf.dev;
      };
    };
  };
}
