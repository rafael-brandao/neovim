{pkgs, ...}: {
  vim.extraPlugins = with pkgs.vimPlugins; {
    transparent-nvim = {
      package = transparent-nvim;
    };
  };
}
