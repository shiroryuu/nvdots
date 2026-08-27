{
    imports = [
        ./cmp.nix
        ./git.nix
        ./mini.nix
        ./oil.nix
        ./telescope.nix
        ./ui
    ];

    vim = {
      lsp.enable = true;
      treesitter.vendorCLI = true;
    };
}
