{
  vim.languages.zig = {
    enable = true;
    treesitter.enable = true;
    # format.enable = true;
    lsp = {
      enable = true;
      servers = ["zls"];
    };
    dap = {
      enable = true;
      debugger = ["lldb"];
    };
  };
}
