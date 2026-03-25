{
  config,
  lib,
  nvf,
  ...
}:
with lib; let
  cfg = config.vim.mini;
in {
  vim = mkMerge [
    {
      mini = {
        icons = {
          enable = true;
        };
        indentscope = {
          enable = true;
          setupOpts = {
            ignore_filetypes = [
              "snacks_dashboard"
              "snacks_terminal"
              "trouble"
            ];
          };
        };
      };
    }

    (mkIf cfg.icons.enable {
      luaConfigRC.mini-plugins-after =
        nvf.lib.nvim.dag.entryAfter ["mappings"]
        # lua
        ''
          -- Mock nvim-web-devicons for plugins without mini.icons support
          M.later(MiniIcons.mock_nvim_web_devicons)
        '';
    })
  ];
}
