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
          skip = pkgs.callPackage ./skip.nix { };
          fake-brew = pkgs.callPackage ./fake-brew.nix { };
          swiftly-symlink = pkgs.callPackage ./swiftly-symlink.nix { };
        }
      );
    };
}
