{
  vim.languages = {
    clang = {
      enable = true;
      cHeader = true;
      treesitter.enable = true;
      format = {
        enable = true;
        type = ["clang-format"];
      };
      lsp = {
        enable = false;
        servers = ["ccls"];
      };
      dap = {
        enable = true;
        debugger = ["lldb"];
      };
    };
    cmake = {
      enable = true;
      treesitter.enable = true;
      lsp = {
        enable = true;
        servers = ["neocmakelsp"];
      };
    };
  };
}
