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
    maps = {
      # ── Normal mode ────────────────────────────────────────────────────────────
      normal = {
        "<leader>ee" = {
          desc = "Open netrw file manager";
          action = ":Ex<CR>";
        };

        "J" = {
          desc = "Join lines while keeping cursor position";
          action = "mzJ`z";
        };

        "<C-d>" = {
          desc = "Scroll down and center the view";
          action = "<C-d>zz";
        };

        "<C-u>" = {
          desc = "Scroll up and center the view";
          action = "<C-u>zz";
        };

        "<leader>cp" = {
          desc = "Paste from the system clipboard";
          lua = true;
          action = ''[["+p]]'';
        };

        "<leader>Y" = {
          desc = "Yank the entire line to the system clipboard";
          lua = true;
          action = ''[["+Y]]'';
        };

        "<leader>d" = {
          desc = "Delete to void register without modifying the current register content";
          lua = true;
          action = ''[["_d]]'';
        };

        "<leader>qq" = {
          desc = "Quit without saving";
          noremap = false;
          action = ":q!<CR>";
        };

        "<leader>ww" = {
          desc = "Save the current buffer";
          noremap = false;
          action = ":w!<CR>";
        };

        "<leader>wq" = {
          desc = "Save the current buffer and quit";
          noremap = false;
          action = ":wq<CR>";
        };

        "<leader>wa" = {
          desc = "Save all open buffers";
          noremap = false;
          action = ":wa<CR>";
        };

        "W" = {
          desc = "Move to the beginning of the line";
          noremap = false;
          action = "^";
        };

        "E" = {
          desc = "Move to the end of the line";
          noremap = false;
          action = "$";
        };

        "<C-j>" = {
          desc = "Jump to the previous item in the quickfix list and center the view";
          action = "<cmd>cprev<CR>zz";
        };

        "<C-k>" = {
          desc = "Jump to the next item in the quickfix list and center the view";
          action = "<cmd>cnext<CR>zz";
        };

        "<leader>j" = {
          desc = "Jump to the previous item in the location list and center the view";
          action = "<cmd>lprev<CR>zz";
        };

        "<leader>k" = {
          desc = "Jump to the next item in the location list and center the view";
          action = "<cmd>lnext<CR>zz";
        };

        # "<C-j>" = {
        #   desc = "Move to the split below";
        #   action = "<C-w><C-j>";
        # };
        #
        # "<C-k>" = {
        #   desc = "Move to the split above";
        #   action = "<C-w><C-k>";
        # };
        #
        # "<C-l>" = {
        #   desc = "Move to the split on the right";
        #   action = "<C-w><C-l>";
        # };
        #
        # "<C-h>" = {
        #   desc = "Move to the split on the left";
        #   action = "<C-w><C-h>";
        # };

        "<M-,>" = {
          desc = "Decrease window width";
          action = "<C-w>5<";
        };

        "<M-.>" = {
          desc = "Increase window width";
          action = "<C-w>5>";
        };

        "<M-t>" = {
          desc = "Increase window height";
          action = "<C-w>+";
        };

        "<M-s>" = {
          desc = "Decrease window height";
          action = "<C-w>-";
        };

        "<leader>x" = {
          desc = "Execute the current line";
          action = "<cmd>.lua<CR>";
        };

        "<leader><leader>x" = {
          desc = "Execute the current file";
          action = "<cmd>source %<CR>";
        };

        "[d" = {
          desc = "Jump to previous diagnostic (with float)";
          lua = true;
          action =
            # lua
            ''
              M.fn(vim.diagnostic.jump, { count = -1, float = true })
            '';
        };

        "]d" = {
          desc = "Jump to next diagnostic (with float)";
          lua = true;
          action =
            # lua
            ''
              M.fn(vim.diagnostic.jump, { count = 1, float = true })
            '';
        };

        "<CR>" = {
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
        };

        "<M-j>" = {
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
        };

        "<M-k>" = {
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
        };

        "<space>tt" = {
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
        };

        "<leader>t" = {
          desc = "Run tests for the current file";
          noremap = false;
          silent = false;
          action = "<Plug>PlenaryTestFile";
        };

        "j" = {
          desc = "Better down movement, considering wrapped lines";
          expr = true;
          silent = true;
          action = "v:count == 0 ? 'gj' : 'j'";
        };

        "k" = {
          desc = "Better up movement, considering wrapped lines";
          expr = true;
          silent = true;
          action = "v:count == 0 ? 'gk' : 'k'";
        };
      };

      # ── Insert mode ────────────────────────────────────────────────────────────
      insert = {
      };

      # ── Visual-only mode (n,x) ─────────────────────────────────────────────────
      visualOnly = {
      };

      # ── Visual + Select mode (v) ───────────────────────────────────────────────
      visual = {
        "<M-j>" = {
          desc = "Move selected lines down, keeping the indentation";
          action = ":m '>+1<CR>gv=gv";
        };

        "<M-k>" = {
          desc = "Move selected lines up, keeping the indentation";
          action = ":m '<-2<CR>gv=gv";
        };
      };

      # ── Normal + Visual + Operator-pending mode (n,v,o) ────────────────────────
      normalVisualOp = {
        "<leader>y" = {
          desc = "Yank to the system clipboard";
          action = ''[["+y]]'';
          lua = true;
        };

        "<leader>d" = {
          desc = "Delete to void register without modifying the current register content";
          action = ''[["_d]]'';
          lua = true;
        };

        "Ç" = {
          desc = "Switch to command mode using ABNT/ABNT2 keyboards";
          action = ":";
          silent = false;
        };
      };
    };

    luaConfigRC.customMappings =
      nvf.lib.nvim.dag.entryAfter ["mappings"]
      # lua
      ''
        vim.keymap.set({"x"}, "<leader>p", [["_dP]], {["desc"] = "Paste preserving the register content",
        ["expr"] = false,
        ["noremap"] = true,
        ["nowait"] = false,
        ["remap"] = false,
        ["script"] = false,
        ["silent"] = true,
        ["unique"] = false})
        vim.keymap.set({"x"}, "<leader>cp", [["_d"+P]], {["desc"] = "Paste from the system clipboard preserving the register content",
        ["expr"] = false,
        ["noremap"] = true,
        ["nowait"] = false,
        ["remap"] = false,
        ["script"] = false,
        ["silent"] = true,
        ["unique"] = false})
        vim.keymap.set({"i",
        "n"}, "<C-z>", function()
          if vim.fn.has("wsl") == 1 then
            return ""
          else
            return vim.keycode "<C-z>"
          end
        end
        , {["desc"] = "Remap Ctrl-Z to Nop if running on WSL",
        ["expr"] = true,
        ["noremap"] = true,
        ["nowait"] = false,
        ["remap"] = false,
        ["script"] = false,
        ["silent"] = true,
        ["unique"] = false})
      '';
  };
}
