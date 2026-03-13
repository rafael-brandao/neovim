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
              icons = require("custom.icons"),
            },
            data = assert(vim.fn.stdpath("data")),
            fn   = require("custom.f").fn,
            later = require("custom.f").later,
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
