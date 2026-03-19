{pkgs, ...}: {
  vim = {
    pluginOverrides = {
      todo-comments = pkgs.vimPlugins.todo-comments-nvim-git;
    };

    notes.todo-comments = {
      enable = true;
    };
  };
}
