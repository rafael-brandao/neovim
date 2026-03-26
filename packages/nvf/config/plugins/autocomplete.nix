{lib, ...}:
with lib; {
  vim.autocomplete.blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;
    setupOpts = {
      keymap = {
        preset = "default";
        "<C-space>" = ["show" "show_documentation" "hide_documentation"];
        "<C-e>" = ["hide" "fallback"];
        "<C-k>" = ["select_prev" "fallback"];
        "<C-j>" = ["select_next" "fallback"];
        "<C-b>" = ["scroll_documentation_up" "fallback"];
        "<C-f>" = ["scroll_documentation_down" "fallback"];
      };

      appearance = {
        nerd_font_variant = "mono";
        use_nvim_cmp_as_default = true;
      };

      completion = {
        trigger = {
          show_on_insert_on_trigger_character = true;
        };

        list = {
          max_items = 200;
          selection = {
            preselect = true;
            auto_insert = false;
          };
        };

        accept = {
          auto_brackets = {
            enabled = true;
            semantic_token_resolution = {
              enabled = false;
            };
          };
        };

        menu = {
          enabled = true;
          min_width = 15;
          max_height = 10;
          border = "rounded";
          winblend = 0;
          scrolloff = 2;

          draw = {
            align_to = "label";
            padding = 1;
            gap = 1;
            treesitter = ["lsp"];
            columns =
              generators.mkLuaInline
              # lua
              ''
                {
                  { "kind_icon" },
                  { "label", "label_description", gap = 1 },
                  { "kind" },
                }
              '';
          };
        };

        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
          treesitter_highlighting = true;
          window = {
            border = "rounded";
            winblend = 0;
          };
        };

        ghost_text = {
          enabled = true;
        };
      };

      sources = {
        default = ["lsp" "path" "snippets" "buffer"];
        providers = {
          lsp = {
            name = "LSP";
            module = "blink.cmp.sources.lsp";
            score_offset = 5;
            fallbacks = []; # intentionally empty — don't fall back when LSP returns nothing
          };
          path = {
            name = "Path";
            module = "blink.cmp.sources.path";
            score_offset = 3;
            opts = {
              trailing_slash = false;
              label_trailing_slash = true;
              show_hidden_files_by_default = false;
            };
          };
          snippets = {
            name = "Snippets";
            module = "blink.cmp.sources.snippets";
            score_offset = 2;
            opts = {
              use_show_condition = true; # use luasnip's show_condition for filtering
              show_autosnippets = true;
            };
          };
          buffer = {
            name = "Buffer";
            module = "blink.cmp.sources.buffer";
            score_offset = 0;
            opts = {
              # use visible window buffers only, excluding nofile buffers
              get_bufnrs =
                generators.mkLuaInline
                # lua
                ''
                  function()
                    return vim.iter(vim.api.nvim_list_wins())
                      :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                      :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                      :totable()
                  end
                '';
            };
          };
        };
      };

      snippets = {
        preset = "luasnip";
      };

      fuzzy = {
        implementation = "prefer_rust_with_warning";
        frecency.enabled = true;
        use_proximity = true;
      };

      signature = {
        enabled = true;
        window = {
          border = "rounded";
          winblend = 0;
        };
      };

      cmdline = {
        enabled = true;
        keymap = {
          preset = "cmdline";
        };
        completion = {
          menu = {
            auto_show = true;
          };
        };
      };
    };
  };
}
