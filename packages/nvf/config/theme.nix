{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkMerge [
    {
      vim = mkOverride 950 {
        theme = {
          enable = true;
          name = "catppuccin";
        };
      };
    }

    (mkIf (config.vim.theme.name == "catppuccin") {
      vim = mkOverride 950 {
        extraPlugins = {
          catppuccin.package = pkgs.vimPlugins.catppuccin-nvim-git;
        };
        theme = {
          style = "mocha";
        };
      };
    })
  ];
}
