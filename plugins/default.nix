{
    imports = [
        ./cmp.nix
        ./git.nix
        ./editor.nix
        ./mini.nix
        ./notes.nix
        ./oil.nix
        ./telescope.nix
        ./ui
    ];

    vim = {
      lsp.enable = true;
      treesitter.vendorCLI = true;
      formatter.conform-nvim.enable = true;
    };
}
