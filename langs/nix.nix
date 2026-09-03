{
    vim.languages.nix = {
        enable = true;
        treesitter.enable = true;
        format = {
            enable = true;
            type = [ "alejandra" ];
        };
        lsp = {
            enable = true;
            servers = ["nixd"];
        };
    };
}
