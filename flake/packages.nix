_: let
  packages = ../packages;
in {
  imports = [
    "${packages}/nvf/flake-part.nix"
  ];
}
