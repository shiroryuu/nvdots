{ ... }:{
    vim.autocomplete.blink-cmp = {
        enable = true;
        setupOpts = {
            sources.default = [ "lsp" "path" "snippets" "buffer" ];
        };
    };
}
