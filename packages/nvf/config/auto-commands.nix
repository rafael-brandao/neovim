{lib, ...}:
with lib; {
  vim = {
    augroups = [
      {name = "auto-create-dir";}
      {name = "last-loc";}
      {name = "resize-splits";}
      {name = "yank-highlight";}
    ];

    autocmds = [
      # Auto-create directory when saving a file (if intermediate dirs don't exist)
      {
        desc = "auto create dir when saving a file, in case some intermediate directory does not exist";
        event = ["BufReadPre"];
        group = "auto-create-dir";
        callback =
          generators.mkLuaInline
          # lua
          ''
            function(event)
              local file = vim.loop.fs_realpath(event.match) or event.match
              vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
            end
          '';
      }

      # Go to last cursor location when opening a buffer
      {
        desc = "go to last loc when opening a buffer";
        event = ["BufReadPost"];
        group = "last-loc";
        callback =
          generators.mkLuaInline
          # lua
          ''
            function()
              local mark = vim.api.nvim_buf_get_mark(0, '"')
              local lcount = vim.api.nvim_buf_line_count(0)
              if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
              end
            end
          '';
      }

      # Resize splits when the window is resized
      {
        desc = "resize splits if window got resized";
        event = ["VimResized"];
        group = "resize-splits";
        callback =
          generators.mkLuaInline
          # lua
          ''
            function()
              vim.cmd('tabdo wincmd =')
            end
          '';
      }

      # Highlight on yank
      {
        desc = "highlight on yank";
        event = ["TextYankPost"];
        group = "yank-highlight";
        pattern = ["*"];
        callback =
          generators.mkLuaInline
          # lua
          ''
            function()
              vim.highlight.on_yank()
            end
          '';
      }
    ];
  };
}
