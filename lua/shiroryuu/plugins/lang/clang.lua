local formatter  = "clang-format"
return {
    -- Add C++ to treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "cpp" } },
    },
    {
        "williamboman/mason.nvim",
        -- optional = true,
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "clang-format",
                "codelldb",
            })
        end,
    },
    -- TODO: Setup p00f/clangd-extensions
    -- Correctly setup lspconfig for C/C++
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {
                    keys = {
                        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                },
            },
        },
    },
    -- TODO: Add debugger & blink.cmp
}
