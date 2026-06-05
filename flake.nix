{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      forEachPlatform = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.darwin;
    in
    {
      packages = forEachPlatform (
        platform:
        let
          pkgs = import inputs.nixpkgs {
            system = platform;
          };
        in
        {
          skip-bin = import ./skip-bin.nix { };
          skip = pkgs.callPackage ./skip.nix { };
          swiftly = pkgs.callPackage ./swiftly.nix { };
          fake-brew = pkgs.callPackage ./fake-brew.nix { };
        }
      );
    };
}
