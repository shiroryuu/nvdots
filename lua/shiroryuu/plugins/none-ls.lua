return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
        {
            "jay-babu/mason-null-ls.nvim",
            dependencies = { "williamboman/mason.nvim" },
            cmd = { "NullLsInstall", "NullLsUninstall" },
            init = function(plugin) require("shiroryuu.utils.plugin").on_load("mason.nvim", plugin.name) end,
            opts = { handlers = {} },
        }
    },
    main = "null-ls",
    event = "User LazyFile",
    opts = function(_, opts)
        local null_ls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
            -- TODO: Add Ansible diagnostics
            --null_ls.builtins.diagnostics.ansiblelint,
            null_ls.builtins.formatting.yamlfix,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.shfmt,
            null_ls.builtins.diagnostics.zsh,
        })

    end,
}
