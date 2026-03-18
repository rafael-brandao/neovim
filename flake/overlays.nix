{
  inputs,
  lib,
  ...
}: let
  overlays = {
    additions = with lib;
      final: prev: let
        inherit (final.stdenv.hostPlatform) system;
      in {
        neovim-nightly = inputs.neovim-nightly.packages.${system}.neovim;

        nil-git = inputs.nil.packages.${system}.nil;

        vimPlugins = with final.vimUtils;
          prev.vimPlugins
          // {
            blink-cmp-nightly = inputs.blink-cmp.packages.${system}.blink-cmp;

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

  mkPkgs = {
    nixpkgs,
    overlays ? [],
    system,
  }:
    import nixpkgs {
      inherit overlays system;
      config.allowUnfree = true;
    };

  pkgsFor = system:
    mkPkgs {
      inherit system;
      inherit (inputs) nixpkgs;
      overlays = lib.attrValues overlays;
    };
in {
  perSystem = {system, ...}: {
    _module.args = {
      pkgs = pkgsFor system;
    };
  };
}
