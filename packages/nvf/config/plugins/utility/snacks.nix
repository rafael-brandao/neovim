{pkgs, ...}: {
  vim = {
    pluginOverrides = {
      snacks-nvim = pkgs.vimPlugins.snacks-nvim-git;
    };

    utility.snacks-nvim = {
      enable = true;
    };
  };
}
