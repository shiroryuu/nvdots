{
    imports = [
        ./cmp.nix
        ./git.nix
        ./editor.nix
        ./mini.nix
        ./notes.nix
        ./ui
        ./utility
    ];

    vim = {
      lsp.enable = true;
      treesitter.vendorCLI = true;
      formatter.conform-nvim.enable = true;
    };
}
