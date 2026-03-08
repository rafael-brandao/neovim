# https://github.com/2KAbhishek/nvim2k/blob/main/lua/core/keys.lua
# https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/core/keymaps.lua
# https://github.com/omerxx/dotfiles/blob/master/nvim/lua/keymaps.lua
# https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
# https://github.com/benfrain/neovim/blob/main/lua/mappings.lua
#
#
# TODO: @keymaps@ standardize keymaps and comments to match TJ Devries ones
{nvf, ...}: {
  vim = {
    keymaps = [
      # ── Normal mode (n)─────────────────────────────────────────────────────────
      {
        mode = "n";
        key = "<leader>ee";
        desc = "Open netrw file manager";
        action = ":Ex<CR>";
      }

      {
        mode = "n";
        key = "J";
        desc = "Join lines while keeping cursor position";
        action = "mzJ`z";
      }

      {
        mode = "n";
        key = "<C-d>";
        desc = "Scroll down and center the view";
        action = "<C-d>zz";
      }

      {
        mode = "n";
        key = "<C-u>";
        desc = "Scroll up and center the view";
        action = "<C-u>zz";
      }

      {
        mode = "n";
        key = "<leader>cp";
        desc = "Paste from the system clipboard";
        lua = true;
        action = ''[["+p]]'';
      }

      {
        mode = "n";
        key = "<leader>Y";
        desc = "Yank the entire line to the system clipboard";
        lua = true;
        action = ''[["+Y]]'';
      }

      {
        mode = "n";
        key = "<leader>qq";
        desc = "Quit without saving";
        noremap = false;
        action = ":q!<CR>";
      }

      {
        mode = "n";
        key = "<leader>ww";
        desc = "Save the current buffer";
        noremap = false;
        action = ":w!<CR>";
      }

      {
        mode = "n";
        key = "<leader>wq";
        desc = "Save the current buffer and quit";
        noremap = false;
        action = ":wq<CR>";
      }

      {
        mode = "n";
        key = "<leader>wa";
        desc = "Save all open buffers";
        noremap = false;
        action = ":wa<CR>";
      }

      {
        mode = "n";
        key = "W";
        desc = "Move to the beginning of the line";
        noremap = false;
        action = "^";
      }

      {
        mode = "n";
        key = "E";
        desc = "Move to the end of the line";
        noremap = false;
        action = "$";
      }

      {
        mode = "n";
        key = "<leader>ql";
        desc = "Open quickfix list";
        action = "<cmd>copen<CR>";
      }

      {
        mode = "n";
        key = "<leader>qc";
        desc = "Close quickfix list";
        action = "<cmd>cclose<CR>";
      }

      {
        mode = "n";
        key = "[q";
        desc = "Jump to the previous item in the quickfix list and center the view";
        action = "<cmd>cprev<CR>zz";
      }

      {
        mode = "n";
        key = "]q";
        desc = "Jump to the next item in the quickfix list and center the view";
        action = "<cmd>cnext<CR>zz";
      }

      {
        mode = "n";
        key = "<leader>ll";
        desc = "Open location list";
        action = "<cmd>lopen<CR>";
      }

      {
        mode = "n";
        key = "<leader>lc";
        desc = "Close location list";
        action = "<cmd>lclose<CR>";
      }

      {
        mode = "n";
        key = "[l";
        desc = "Jump to the previous item in the location list and center the view";
        action = "<cmd>lprev<CR>zz";
      }

      {
        mode = "n";
        key = "]l";
        desc = "Jump to the next item in the location list and center the view";
        action = "<cmd>lnext<CR>zz";
      }

      {
        mode = "n";
        key = "<C-h>";
        desc = "Go to the left window";
        action = "<C-w>h";
      }

      {
        mode = "n";
        key = "<C-j>";
        desc = "Go to the window below";
        action = "<C-w>j";
      }

      {
        mode = "n";
        key = "<C-k>";
        desc = "Go to the window above";
        action = "<C-w>k";
      }

      {
        mode = "n";
        key = "<C-l>";
        desc = "Go to the window to the right";
        action = "<C-w>l";
      }

      {
        mode = "n";
        key = "<M-,>";
        desc = "Decrease window width";
        action = "<C-w>5<";
      }

      {
        mode = "n";
        key = "<M-.>";
        desc = "Increase window width";
        action = "<C-w>5>";
      }

      {
        mode = "n";
        key = "<M-t>";
        desc = "Increase window height";
        action = "<C-w>+";
      }

      {
        mode = "n";
        key = "<M-s>";
        desc = "Decrease window height";
        action = "<C-w>-";
      }

      {
        mode = "n";
        key = "<leader>x";
        desc = "Execute the current line";
        action = "<cmd>.lua<CR>";
      }

      {
        mode = "n";
        key = "<leader><leader>x";
        desc = "Execute the current file";
        action = "<cmd>source %<CR>";
      }

      {
        mode = "n";
        key = "[d";
        desc = "Jump to previous diagnostic (with float)";
        lua = true;
        action =
          # lua
          ''
            M.fn(vim.diagnostic.jump, { count = -1, float = true })
          '';
      }

      {
        mode = "n";
        key = "]d";
        desc = "Jump to next diagnostic (with float)";
        lua = true;
        action =
          # lua
          ''
            M.fn(vim.diagnostic.jump, { count = 1, float = true })
          '';
      }

      {
        mode = "n";
        key = "<CR>";
        desc = "Toggle hlsearch if it's on, otherwise just do 'enter'";
        expr = true;
        lua = true;
        action =
          # lua
          ''
            function()
              if vim.v.hlsearch == 1 then
                vim.cmd.nohl()
                return ""
              else
                return vim.keycode "<CR>"
              end
            end
          '';
      }

      {
        mode = "n";
        key = "<M-j>";
        desc = "Move the current line down (diff mode: change)";
        expr = true;
        lua = true;
        action =
          # lua
          ''
            function()
              if vim.opt.diff:get() then
                vim.cmd [[normal! ]c]]
              else
                vim.cmd [[m .+1<CR>==]]
              end
            end
          '';
      }

      {
        mode = "n";
        key = "<M-k>";
        desc = "Move the current line up (diff mode: change)";
        expr = true;
        lua = true;
        action =
          # lua
          ''
            function()
              if vim.opt.diff:get() then
                vim.cmd [[normal! [c]]
              else
                vim.cmd [[m .-2<CR>==]]
              end
            end
          '';
      }

      {
        mode = "n";
        key = "<space>tt";
        desc = "Toggle LSP inlay hints";
        expr = true;
        lua = true;
        action =
          # lua
          ''
            function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 }
              )
            end
          '';
      }

      {
        mode = "n";
        key = "<leader><leader>t";
        desc = "Run tests for the current file";
        noremap = false;
        silent = false;
        action = "<Plug>PlenaryTestFile";
      }

      {
        mode = "n";
        key = "j";
        desc = "Better down movement, considering wrapped lines";
        expr = true;
        silent = true;
        action = "v:count == 0 ? 'gj' : 'j'";
      }

      {
        mode = "n";
        key = "k";
        desc = "Better up movement, considering wrapped lines";
        expr = true;
        silent = true;
        action = "v:count == 0 ? 'gk' : 'k'";
      }

      {
        mode = "n";
        key = "n";
        desc = "Search forward and center the view";
        lua = true;
        action =
          # lua
          ''
            function()
              vim.cmd("silent normal! nzzzv")
              M.keymaps.callbacks.search_forward()
            end
          '';
      }

      {
        mode = "n";
        key = "N";
        desc = "Search backward and center the view";
        lua = true;
        action =
          # lua
          ''
            function()
              vim.cmd("silent normal! Nzzzv")
              M.keymaps.callbacks.search_backward()
            end
          '';
      }

      # ── Visual + Select mode (v) ───────────────────────────────────────────────
      {
        mode = "v";
        key = "<M-j>";
        desc = "Move selected lines down, keeping the indentation";
        action = ":m '>+1<CR>gv=gv";
      }

      {
        mode = "v";
        key = "<M-k>";
        desc = "Move selected lines up, keeping the indentation";
        action = ":m '<-2<CR>gv=gv";
      }

      # ── Normal + Visual + Operator-pending mode (n,v,o) ────────────────────────
      {
        mode = ["n" "v" "o"];
        key = "<leader>y";
        desc = "Yank to the system clipboard";
        lua = true;
        action = ''[["+y]]'';
      }

      {
        mode = ["n" "v" "o"];
        key = "<leader>d";
        desc = "Delete to void register without modifying the current register content";
        lua = true;
        action = ''[["_d]]'';
      }

      {
        mode = ["n" "v" "o"];
        key = "Ç";
        desc = "Switch to command mode using ABNT/ABNT2 keyboards";
        silent = false;
        action = ":";
      }

      # ── Normal and insert modes (n,i) ──────────────────────────────────────────
      {
        mode = ["n" "i"];
        key = "<C-z>";
        desc = "Remap Ctrl-Z to Nop if running on WSL";
        expr = true;
        lua = true;
        action =
          # lua
          ''
            function()
              if vim.fn.has("wsl") == 1 then
                return ""
              else
                return vim.keycode "<C-z>"
              end
            end
          '';
      }

      # ── Visual-only mode (x) ─────────────────────────────────────────────────
      {
        mode = ["x"];
        key = "<leader>p";
        desc = "Paste preserving the register content";
        lua = true;
        action =
          # lua
          ''[["_dP]]'';
      }

      {
        mode = ["x"];
        key = "<leader>cp";
        desc = "Paste from the system clipboard preserving the register content";
        lua = true;
        action =
          # lua
          ''[["_d"+P]]'';
      }
    ];

    luaConfigRC = {
      customMappingsPre =
        nvf.lib.nvim.dag.entryBetween ["mappings"] ["extraPluginConfigs"]
        # lua
        ''
          M.keymaps = {}

          M.keymaps.callbacks = {
            search_forward = function() end,
            search_backward = function() end,
          }
        '';
    };
  };
}
