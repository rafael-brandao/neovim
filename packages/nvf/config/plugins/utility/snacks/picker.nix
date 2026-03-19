{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (generators) mkLuaInline;
in {
  vim = {
    utility.snacks-nvim.setupOpts.picker = mkMerge [
      {
        db = {
          sqlite3_path = "${pkgs.sqlite.out}/lib/libsqlite3.so";
        };
        formatters.file.filename_first = true;
        matcher.cwd_bonus = true;
        win.input.keys = {
          "<C-y>" =
            mkLuaInline
            # lua
            "{ 'confirm', mode = { 'n', 'i' } }";
        };
      }
      (mkIf config.vim.lsp.trouble.enable {
        actions =
          mkLuaInline
          # lua
          "require('trouble.sources.snacks').actions";
        win.input.keys = {
          "<C-t>" =
            mkLuaInline
            # lua
            "{ 'trouble_open', mode = { 'n', 'i' } }";
        };
      })
    ];

    keymaps = mkMerge [
      [
        # Snacks picker mappings
        {
          mode = ["n"];
          key = "<leader>,";
          desc = "Buffers";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.buffers() end";
        }
        {
          mode = ["n"];
          key = "<leader>/";
          desc = "Grep";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.grep() end";
        }
        {
          mode = ["n"];
          key = "<leader>:";
          desc = "Command History";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.command_history() end";
        }
        {
          mode = ["n"];
          key = "<leader><space>";
          desc = "Smart Find Files";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.smart() end";
        }

        # Find
        {
          mode = ["n"];
          key = "<leader>fb";
          desc = "Buffers";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.buffers() end";
        }
        {
          mode = ["n"];
          key = "<leader>fc";
          desc = "Find Config File";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
        }
        {
          mode = ["n"];
          key = "<leader>ff";
          desc = "Find Files";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.files() end";
        }
        {
          mode = ["n"];
          key = "<leader>fg";
          desc = "Find Git Files";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.git_files() end";
        }
        {
          mode = ["n"];
          key = "<leader>fr";
          desc = "Recent Files Within CWD";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.recent( {filter = {cwd = true} }) end";
        }
        {
          mode = ["n"];
          key = "<leader>fR";
          desc = "Recent Files";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.recent() end";
        }

        # Git
        {
          mode = ["n"];
          key = "<leader>gc";
          desc = "Git Log";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.git_log() end";
        }
        {
          mode = ["n"];
          key = "<leader>gs";
          desc = "Git Status";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.git_status() end";
        }

        # Grep
        {
          mode = ["n"];
          key = "<leader>sb";
          desc = "Buffer Lines";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.lines() end";
        }
        {
          mode = ["n"];
          key = "<leader>sB";
          desc = "Grep Open Buffers";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.grep_buffers() end";
        }
        {
          mode = ["n"];
          key = "<leader>sg";
          desc = "Grep";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.grep() end";
        }
        {
          mode = ["n" "x"];
          key = "<leader>sw";
          desc = "Visual selection or word";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.grep_word() end";
        }

        # Search
        {
          mode = ["n"];
          key = "<leader>s\"";
          desc = "Registers";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.registers() end";
        }
        {
          mode = ["n"];
          key = "<leader>sa";
          desc = "Autocmds";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.autocmds() end";
        }
        {
          mode = ["n"];
          key = "<leader>sc";
          desc = "Command History";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.command_history() end";
        }
        {
          mode = ["n"];
          key = "<leader>sC";
          desc = "Commands";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.commands() end";
        }
        {
          mode = ["n"];
          key = "<leader>sd";
          desc = "Diagnostics";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.diagnostics() end";
        }
        {
          mode = ["n"];
          key = "<leader>sh";
          desc = "Help Pages";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.help() end";
        }
        {
          mode = ["n"];
          key = "<leader>sH";
          desc = "Highlights";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.highlights() end";
        }
        {
          mode = ["n"];
          key = "<leader>sj";
          desc = "Jumps";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.jumps() end";
        }
        {
          mode = ["n"];
          key = "<leader>sk";
          desc = "Keymaps";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.keymaps() end";
        }
        {
          mode = ["n"];
          key = "<leader>sl";
          desc = "Location List";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.loclist() end";
        }
        {
          mode = ["n"];
          key = "<leader>sM";
          desc = "Man Pages";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.man() end";
        }
        {
          mode = ["n"];
          key = "<leader>sm";
          desc = "Marks";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.marks() end";
        }
        {
          mode = ["n"];
          key = "<leader>sR";
          desc = "Resume";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.resume() end";
        }
        {
          mode = ["n"];
          key = "<leader>sq";
          desc = "Quickfix List";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.qflist() end";
        }
        {
          mode = ["n"];
          key = "<leader>uC";
          desc = "Colorschemes";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.colorschemes() end";
        }
        {
          mode = ["n"];
          key = "<leader>qp";
          desc = "Projects";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.projects() end";
        }

        # LSP
        {
          mode = ["n"];
          key = "gd";
          desc = "Goto Definition";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.lsp_definitions() end";
        }
        {
          mode = ["n"];
          key = "gr";
          desc = "References";
          lua = true;
          nowait = true;
          action =
            # lua
            "function() Snacks.picker.lsp_references() end";
        }
        {
          mode = ["n"];
          key = "gI";
          desc = "Goto Implementation";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.lsp_implementations() end";
        }
        {
          mode = ["n"];
          key = "gy";
          desc = "Goto T[y]pe Definition";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.lsp_type_definitions() end";
        }
        {
          mode = ["n"];
          key = "<leader>ss";
          desc = "LSP Symbols";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.lsp_symbols() end";
        }
      ]
      (mkIf config.vim.notes.todo-comments.enable [
        {
          mode = ["n"];
          key = "<leader>st";
          desc = "Todo";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.todo_comments() end";
        }
        {
          mode = ["n"];
          key = "<leader>sT";
          desc = "Todo/Fix/Fixme";
          lua = true;
          action =
            # lua
            "function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end";
        }
      ])
    ];
  };
}
