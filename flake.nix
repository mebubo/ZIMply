{
  description = "A ZIM file server based on ZIMply";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    {
      nixosModules.default = { pkgs, lib, config, ... }:
        import ./zimply-service.nix {
          inherit pkgs lib config;
        };
    };
}
