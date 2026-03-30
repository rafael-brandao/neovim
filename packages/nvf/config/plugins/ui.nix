{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  snacks = with config.vim.utility.snacks-nvim; {
    notifier.enabled = attrByPath ["notifier" "enabled"] false setupOpts;
  };
in {
  vim = {
    ui = {
      colorizer = {
        enable = true;
        setupOpts = {
          filetypes = {
            "!text" = {};
            "*" = {};
          };
          user_default_options = {
            rgb_fn = true; # rgb() and rgba()
            hsl_fn = true; # hsl() and hsla()
            names = true; # named colors like "red", "blue"
            RGB = true; # #RGB short hex
            RRGGBB = true; # #RRGGBB hex
            mode = "virtualtext";
            virtualtext = "■"; # character to display, defaults to "■"
          };
        };
      };
      modes-nvim = {
        enable = true;
        setupOpts = {
          line_opacity = {
            visual = 0.5;
          };
          setCursorline = true;
        };
      };
      noice = {
        enable = true;
        setupOpts = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
          };
          notify = {
            enabled = !snacks.notifier.enabled;
          };
          presets = {
            bottom_search = true; # use a classic bottom cmdline for search
            command_palette = true; # position the cmdline and popupmenu together
            long_message_to_split = true; # long messages will be sent to a split
          };
        };
      };
    };
    pluginOverrides = {
      modes-nvim = pkgs.vimPlugins.modes-nvim-git;
    };
  };
}
