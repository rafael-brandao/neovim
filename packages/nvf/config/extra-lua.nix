{nvf, ...}: {
  vim = {
    additionalRuntimePaths = [./extra-lua];

    luaConfigRC.customGlobalsScript =
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
  };
}
