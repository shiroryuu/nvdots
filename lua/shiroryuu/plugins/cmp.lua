return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        version = false,  -- its been 2 years since the last tagged release
        dependencies = {
            "hrsh7th/nvim-cmp-lsp",
            "hrsh7th/nvim-buffer",
            "hrsh7th/nvim-path",
            "hrsh7th/nvim-cmdline",
        },
        opts = function()
            local cmp = require("cmp")
            local defaults = cmp.config.default()
            local cmp_lsp = require("nvim_cmp_lsp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            return  {
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources =  cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                        { name = "buffer" },
                    }),
                sorting = defaults.sorting,
            }
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "onsails/lspkind.nvim",
        enabled = vim.g.icons_enabled ~= false,
        opts = {
            mode = "symbol",
            symbol_map = {
                Array = "󰅪",
                Boolean = "⊨",
                Class = "󰌗",
                Constructor = "",
                Key = "󰌆",
                Namespace = "󰅪",
                Null = "NULL",
                Number = "#",
                Object = "󰀚",
                Package = "󰏗",
                Property = "",
                Reference = "",
                Snippet = "",
                String = "󰀬",
                TypeParameter = "󰊄",
                Unit = "",
            },
        },
        config = function(_, opts)
            require("lspkind").init(opts)
        end
    }
},
