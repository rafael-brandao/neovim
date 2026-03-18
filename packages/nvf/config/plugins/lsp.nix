{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  vim = mkMerge [
    {
      # ────────────────────────────────────────────────
      # Core LSP
      # ────────────────────────────────────────────────
      lsp = {
        enable = true;
        inlayHints.enable = true;

        # Signature help (correct name in current NVF)
        lspSignature.enable = true;

        # ────────────────────────────────────────────────
        # LSP Servers
        # ────────────────────────────────────────────────
        servers = {
          bashls.enable = true;
          fish_lsp.enable = true;
          lua_ls.enable = true;
          markdown_oxide.enable = true;

          nixd = {
            enable = true;
            package = pkgs.nixd;
            cmd = [(getExe pkgs.nixd)];
            filetypes = ["nix"];
            settings = {
              formatting.command = [(getExe pkgs.alejandra)];
            };
          };

          powershell_es = {
            enable = true;
            package = pkgs.powershell-editor-services;
          };

          statix.enable = true;
          taplo.enable = true;
          yamlls.enable = true;
        };

        # ────────────────────────────────────────────────
        # Null-ls (statix + deadnix)
        # ────────────────────────────────────────────────
        null-ls = {
          enable = true;
          setupOpts = {
            sources = let
              sources = [
                "code_actions.statix"
                "diagnostics.deadnix"
                "diagnostics.statix"
              ];
              mapFn = source: generators.mkLuaInline "require('null-ls').builtins.${source}";
            in
              map mapFn sources;
          };
        };

        # ────────────────────────────────────────────────
        # Otter nvim
        # ────────────────────────────────────────────────
        otter-nvim = {
          enable = true;
          setupOpts = {
            handle_leading_whitespace = true;
          };
        };

        # ────────────────────────────────────────────────
        # Trouble nvim
        # ────────────────────────────────────────────────
        trouble = {
          enable = true;
        };
      };

      # ────────────────────────────────────────────────
      # Formatting with conform-nvim (your original logic)
      # ────────────────────────────────────────────────
      formatter = {
        conform-nvim = {
          enable = true;
          setupOpts = {
            log_level = 2; # warn

            formatters_by_ft = {
              bash = ["shellcheck" "shellharden" "shfmt"];
              json = ["jsonfmt"];
              lua = ["stylua"];
              nix = ["alejandra"];
              toml = ["toml-sort"];
              yaml = ["yamlfmt"];
              yml = ["yamlfmt"];
              "_" = ["squeeze_blanks" "trim_whitespace" "trim_newlines"];
            };

            default_format_opts = {
              async = true;
              lsp_format = "fallback";
            };

            formatters = {
              alejandra.command = getExe pkgs.alejandra;
              jsonfmt.command = getExe pkgs.jsonfmt;
              shellcheck.command = getExe pkgs.shellcheck;
              shellharden.command = getExe pkgs.shellharden;
              shfmt.command = getExe pkgs.shfmt;
              squeeze_blanks.command = getExe' pkgs.coreutils "cat";
              stylua.command = getExe pkgs.stylua;
              toml-sort.command = getExe pkgs.toml-sort;
              yamlfmt.command = getExe pkgs.yamlfmt;
            };
          };
        };
      };

      # ────────────────────────────────────────────────
      # Neovim Diagnostics
      # ────────────────────────────────────────────────
      diagnostics = {
        enable = true;
        config = {
          virtual_lines = mkDefault true;
        };
      };
    }

    # ────────────────────────────────────────────────
    # Tiny inline diagnostic plugin
    # ────────────────────────────────────────────────
    (mkIf config.vim.diagnostics.enable {
      diagnostics = {
        config.virtual_lines = false;
      };

      extraPlugins = {
        tiny-inline-diagnostic-nvim = {
          package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim-git;
          setup =
            # lua
            ''
              require("tiny-inline-diagnostic").setup({
                options = {
                  add_messages = {
                    display_count = true,
                  },
                  multilines = {
                    enabled = true,
                  },
                  show_source = {
                    enabled = true,
                  },
                },
              })
            '';
        };
      };
    })

    # ────────────────────────────────────────────────
    # Custom <leader>f format keymap
    # ────────────────────────────────────────────────
    (mkIf config.vim.formatter.conform-nvim.enable {
      autocmds = [
        {
          desc = "Set custom LSP format keymap (<leader>f) on attach";
          event = ["LspAttach"];
          callback =
            generators.mkLuaInline
            # lua
            ''
              function(event)
                local bufnr = event.buf
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if not client:supports_method("textDocument/formatting") then
                  return
                end

                vim.keymap.set(
                  { "n", "v" },
                  "<leader>f",
                  function()
                    require("conform").format({ async = true }, function(err)
                      if err then return end
                      local mode = vim.api.nvim_get_mode().mode
                      if not vim.startswith(string.lower(mode), "v") then return end
                      vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                        "n",
                        true
                      )
                    end)
                  end,
                  { buffer = bufnr, desc = "LSP: Format current buffer" }
                )
              end
            '';
        }
      ];
    })
  ];
}
