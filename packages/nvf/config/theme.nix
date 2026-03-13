{
  config,
  lib,
  ...
}:
with lib; {
  vim.theme = mkMerge [
    (
      mkOverride 950 {
        enable = true;
        name = "catppuccin";
      }
    )
    (mkIf (config.vim.theme.name == "catppuccin") {
      style = "mocha";
    })
  ];
}
