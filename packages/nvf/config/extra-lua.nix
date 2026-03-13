{nvf, ...}: {
  vim = {
    additionalRuntimePaths = [./extra-lua];

    luaConfigRC = {
      customGlobalsScript =
        nvf.lib.nvim.dag.entryBetween ["basic"] ["globalsScript"]
        # lua
        ''
          local M = {
            custom = {
              f = require("custom.f"),
            },
            fn   = require("custom.f").fn,
            data = assert(vim.fn.stdpath("data")),
          }
        '';

      filetype-mappings =
        nvf.lib.nvim.dag.entryBefore ["lazyConfigs"]
        # lua
        ''
          -- Custom filetype associations
          vim.filetype.add({
            extension = {
              -- h = "c",   -- uncomment if you ever need it
            },
            filename = {
              ["flake.lock"] = "json",
              [".yamlfmt"]   = "yaml",
              [".yamllint"]  = "yaml",
            },
          })
        '';
    };
  };
}
