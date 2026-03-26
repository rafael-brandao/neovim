{
  config,
  lib,
  nvf,
  pkgs,
  ...
}:
with lib; let
  cfg = config.vim.utility.snacks-nvim;
  snacks = {
    hasEnabled = feature: attrByPath [feature "enabled"] false cfg.setupOpts;
  };
in {
  imports = [
    ./snacks/explorer.nix
    ./snacks/picker.nix
  ];

  vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        animate = {
          enabled = true;
          duration = 20; # ms per step
          easing = "linear";
          fps = 60;
        };
        bigfile = {
          enabled = true;
          notify = true;
          size = 50 * 1024; # ~ 50 KB
        };
        bufdelete = {
          enabled = true;
        };
        dashboard = {
          enabled = true;
        };
        debug = {
          enabled = true;
        };
        explorer = {
          enabled = true;
        };
        git = {
          enabled = true;
        };
        gitbrowse = {
          enabled = true;
        };
        image = {
          enabled = true;
        };
        input = {
          enabled = true;
        };
        notifier = {
          enabled = true;
          style = "fancy";
          timeout = 3000;
        };
        picker = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
        scope = {
          enabled = true;
        };
        scroll = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
        styles = {
          notification_history = {
            width = 0.75;
            height = 0.75;
            wo = {
              wrap = true;
            };
          };
        };
        toggle = {
          enabled = true;
        };
        words = {
          enabled = true;
          debounce = 100;
        };
        zen = {
          enabled = true;
          toggles = {
            dim = false;
          };
        };
      };
    };

    extraPackages = with pkgs;
      mkMerge [
        (mkIf (snacks.hasEnabled "image") [
          # Core image conversion (non-PNG → PNG)
          imagemagick

          # PDF rendering
          ghostscript

          # LaTeX math rendering
          tectonic # ← recommended: small, modern, automatic

          # Mermaid diagrams
          mermaid-cli
        ])
      ];

    extraPlugins = with pkgs.vimPlugins;
      mkMerge [
        (mkIf (snacks.hasEnabled "dashboard") {
          lazy-nvim = {
            package = lazy-nvim;
          };
        })
      ];

    pluginOverrides = {
      snacks-nvim = pkgs.vimPlugins.snacks-nvim-git;
    };

    keymaps = mkIf cfg.enable (
      mkMerge [
        [
          {
            mode = "n";
            key = "<leader>z";
            desc = "Toggle Zen Mode";
            lua = true;
            action =
              # lua
              "function() Snacks.zen() end";
          }
          {
            mode = "n";
            key = "<leader>Z";
            desc = "Toggle Zoom";
            lua = true;
            action =
              # lua
              "function() Snacks.zen.zoom() end";
          }
          {
            mode = "n";
            key = "<leader>.";
            desc = "Toggle Scratch Buffer";
            lua = true;
            action =
              # lua
              "function() Snacks.scratch() end";
          }
          {
            mode = "n";
            key = "<leader>S";
            desc = "Select Scratch Buffer";
            lua = true;
            action =
              # lua
              "function() Snacks.scratch.select() end";
          }
          {
            mode = "n";
            key = "<leader>n";
            desc = "Notification History";
            lua = true;
            action =
              # lua
              "function() Snacks.notifier.show_history() end";
          }
          {
            mode = "n";
            key = "<leader>bd";
            desc = "Delete Buffer";
            lua = true;
            action =
              # lua
              "function() Snacks.bufdelete() end";
          }
          {
            mode = "n";
            key = "<leader>cR";
            desc = "Rename File";
            lua = true;
            action =
              # lua
              "function() Snacks.rename.rename_file() end";
          }
          {
            mode = "n";
            key = "<leader>gb";
            desc = "Git Blame Line";
            lua = true;
            action =
              # lua
              "function() Snacks.git.blame_line() end";
          }
          {
            mode = "n";
            key = "<leader>un";
            desc = "Dismiss All Notifications";
            lua = true;
            action =
              # lua
              "function() Snacks.notifier.hide() end";
          }
          {
            mode = "n";
            key = "<leader>N";
            desc = "Neovim News";
            lua = true;
            action =
              # lua
              ''
                function()
                  Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                      conceallevel = 3,
                      signcolumn = "yes",
                      spell = false,
                      statuscolumn = " ",
                      wrap = false,
                    },
                  })
                end
              '';
          }
          {
            mode = ["n" "t"];
            key = "<C-/>";
            desc = "Toggle Centered Terminal";
            lua = true;
            action =
              # lua
              ''
                function()
                  -- adapted from https://www.reddit.com/r/neovim/comments/1gv4z6k/comment/ly2jpif/
                  -- Check if we're in terminal mode
                  if vim.bo.buftype == "terminal" then
                    vim.cmd("hide") -- Hide the terminal if we're in terminal mode
                  else
                    -- Show/create terminal if we're in normal mode
                    Snacks.terminal.toggle(vim.env.SHELL, {
                      env = {
                        TERM = "xterm-256color",
                      },
                      win = {
                        position = "float",
                        style = "terminal",
                        relative = "editor",
                        width = 0.83,
                        height = 0.83,
                      },
                    })
                  end
                end
              '';
          }
          {
            mode = ["n" "t"];
            key = "[[";
            desc = "Prev Reference";
            lua = true;
            action =
              # lua
              "function() Snacks.words.jump(-vim.v.count1) end";
          }
          {
            mode = ["n" "t"];
            key = "]]";
            desc = "Next Reference";
            lua = true;
            action =
              # lua
              "function() Snacks.words.jump(vim.v.count1) end";
          }
          {
            mode = ["n" "v"];
            key = "<leader>gB";
            desc = "Git Browse";
            lua = true;
            action =
              # lua
              "function() Snacks.gitbrowse() end";
          }
        ]

        (mkIf (attrByPath ["vim" "git" "lazygit" "enable"] false config) [
          {
            mode = "n";
            key = "<leader>gf";
            desc = "Lazygit Current File History";
            lua = true;
            action =
              # lua
              "function() Snacks.lazygit.log_file() end";
          }
          {
            mode = "n";
            key = "<leader>gg";
            desc = "Lazygit";
            lua = true;
            action =
              # lua
              "function() Snacks.lazygit() end";
          }
          {
            mode = "n";
            key = "<leader>gl";
            desc = "Lazygit Log (cwd)";
            lua = true;
            action =
              # lua
              "function() Snacks.lazygit.log() end";
          }
        ])
      ]
    );

    luaConfigRC.snacks-nvim-after =
      nvf.lib.nvim.dag.entryAfter ["mappings"]
      # lua
      ''
        -- Setup some globals for debugging (lazy-loaded)
        M.dd = function(...)
          Snacks.debug.inspect(...)
        end
        M.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = M.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      '';
  };
}
