{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.utility.snacks-nvim.setupOpts.explorer;
in
  mkIf cfg.enabled {
    vim.keymaps = [
      {
        mode = ["n"];
        key = "<leader>e";
        desc = "File Explorer";
        lua = true;
        action =
          # lua
          "function() Snacks.explorer() end";
      }
    ];
  }
