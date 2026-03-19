{
  config,
  lib,
  nvf,
  ...
}:
with lib; {
  vim = mkMerge [
    {
      statusline.lualine = {
        enable = mkDefault true;
        disabledFiletypes = [
          "netrw"
          "snacks_dashboard"
        ];
        extraActiveSection = {
          z = [
            # lua
            ''
              {"selectioncount"}
            ''
          ];
        };
      };
    }
    (mkIf config.vim.statusline.lualine.enable {
      luaConfigRC.customMappingsLualinePre =
        nvf.lib.nvim.dag.entryBetween ["mappings"] ["customMappingsPre"]
        # lua
        ''
          M.keymaps.callbacks = {
            search_forward = require("lualine").refresh,
            search_backward = require("lualine").refresh,
          }
        '';

      options = {
        showmode = false;
      };
    })
  ];
}
