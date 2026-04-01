{
  inputs,
  lib,
  ...
}:
with lib; let
  mkPkgs = {
    nixpkgs,
    overlays ? [],
    system,
  }:
    import nixpkgs {
      inherit overlays system;
      # config.allowUnfree = true;
    };

  pkgsFor = system:
    mkPkgs {
      inherit system;
      inherit (inputs) nixpkgs;
      overlays = attrValues inputs.self.overlays;
    };
in {
  perSystem = {system, ...}: {
    _module.args = {
      pkgs = pkgsFor system;
    };
  };
}
