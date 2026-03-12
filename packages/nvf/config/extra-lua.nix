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
          },
          fn   = require("custom.f").fn,
          data = assert(vim.fn.stdpath("data")),
        }
      '';
  };
}
