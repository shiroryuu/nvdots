{
    description = "Shiroryuu's NVF Standalone Neovim Flake";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nvf = {
            url = "github:NotAShelf/nvf/main";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = {
        nixpkgs,
        nvf,
        ...
        }:
        let
            inherit (nixpkgs) lib;
            systems = [ "x86_64-linux" ];
            mkForEachSystem = f: lib.genAttrs systems (system: f system);
        in
            {
            packages = mkForEachSystem (
                system: let
                    pkgs = nixpkgs.legacyPackages.${system};
                    customNeovim = nvf.lib.neovimConfiguration {
                        inherit pkgs;
                        modules = [ ./default.nix ];
                    };
                in {
                    default = customNeovim.neovim;
                }
            );
            # devshells = ;
            # formatter =;
        };
}
