{
  vim.languages.rust = {
    enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
      type = ["rustfmt"];
    };
    lsp = {
      enable = true;
      servers = ["rust-analyzer"];
    };
    dap = {
      enable = true;
      debugger = ["codelldb"];
    };
    extensions = {
      crates-nvim = {
        enable = true;
        setupOpts = {
          lsp.enabled = true;
          completion.crates.enabled = true;
        };
      };
      ferris-nvim = {
        enable = true;
        setupOpts.create_commands = true;
      };
    };
  };
}
