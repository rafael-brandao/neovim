{inputs, ...}: {
  imports = with inputs; [
    flake-root.flakeModule
  ];
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      name = "my-neovim-shell";
      inputsFrom = with config; [
        flake-root.devShell
        just-flake.outputs.devShell
        treefmt.build.devShell
      ];
      packages = with pkgs; [
        bat
        git
        jujutsu
        nixVersions.latest
        tokei
      ];
    };
  };
}
