{
    imports = [
        ./cmp.nix
        ./git.nix
        ./editor
        ./mini.nix
        ./notes.nix
        ./ui
        ./utility
    ];

    vim = {
      treesitter.vendorCLI = true;
      formatter.conform-nvim.enable = true;
    };
}
