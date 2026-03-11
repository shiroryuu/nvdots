return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- RM: barely used
            -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true, lazy = true, dependencies = { "nvim-lspconfig" } },
            -- RM: Moved to lazydev, check cmp.lua
            -- { "folke/neodev.nvim", opts = {} },
            { "stevearc/conform.nvim" },
            { "williamboman/mason.nvim", },
            {
                "williamboman/mason-lspconfig.nvim",
                cmd = { "LspInstall", "LspUninstall" },
                init = function(plugin)
                    require("shiroryuu.utils.plugins").on_load("mason.nvim", plugin.name)
                end,
                opts = {},
            },
            { "j-hui/fidget.nvim", opts = {} },
        },
        cmd = function(_, cmds)
            if require("shiroryuu.utils.plugins").is_available("neoconf.nvim") then
                table.insert(cmds, "Neoconf")
            end
            vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" })
        end,
        opts_extend = { "servers.*.keys" },
        event = { "BufReadPre", "BufNewFile" },
        opts = function()
            local lsp_icons = require("shiroryuu.utils.icon").get_icons("Diagnostics", 1)
            return {
                diagnostics = {
                    underline = true,
                    update_in_insert = true,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "●" ,
                    },
                    severity_sort = true,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.WARN] = lsp_icons.Warn,
                            [vim.diagnostic.severity.INFO] = lsp_icons.Info,
                            [vim.diagnostic.severity.HINT] = lsp_icons.Hint,
                            [vim.diagnostic.severity.ERROR] = lsp_icons.Error,
                        },
                    },
                },
                inlay_hints = {
                    enabled = true,
                    exclude = {},
                },
                codelens = {
                    enabled = false,
                },
                document_highlight = {
                    enabled = true,
                },

                folds = {
                    enabled = true,
                },
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },
                servers = {
                    -- configuration for all lsp servers
                    ["*"] = {
                        capabilities = {
                            workspace = {
                                fileOperations = {
                                    didRename = true,
                                    willRename = true,
                                },
                            },
                        },
                        keys = {
                            { "gd", vim.lsp.buf.definition, mode = "n", desc = "Goto Definition" },
                            { "gD", vim.lsp.buf.declaration, mode = "n", desc = "Goto Declaration" },
                            { "gi", vim.lsp.buf.implementation, mode = "n", desc = "Goto Implementation" },
                            { "gy", vim.lsp.buf.type_definition, mode = "n", desc = "Goto T[y]pe Definition" },
                            { "gr", vim.lsp.buf.references, mode = "n", desc = "List References of current symbol", },
                            { "K", function() return vim.lsp.buf.hover() end, mode = "n", desc = "Hover" },
                            { "gK", function() return vim.lsp.buf.signature_help() end,
                            desc = "Signature Help", has = "signatureHelp" },
                            { "<C-h>", function() vim.lsp.buf.signature_help() end, mode = "i",
                            desc = "Signature Help", has = "signatueHelp" },
                            { "[d", function() vim.diagnostic.goto_next() end, mode = "n", },
                            { "]d", function() vim.diagnostic.goto_prev() end, mode = "n", },
                            { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
                            desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
                            { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
                            desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
                            { "<Leader>ca", vim.lsp.buf.code_action, desc = "[c]ode [a]ction", mode = { "n", "v" } },
                            {
                                "<Leader>cA",
                                function()
                                    vim.lsp.buf.code_action({
                                        context = {
                                            only = {
                                                "source",
                                            },
                                            diagnostics = {},
                                        },
                                    })
                                end,
                                desc = "[c]ode source [A]ction",
                            },
                            { "<Leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens", },
                            { "<Leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens", },
                            { "<Leader>cr", vim.lsp.buf.rename, mode = "n", desc = "Rename", },
                            -- TODO: Add Range format (mode:V)
                            { "<Leader>cf",
                            function()
                                local has_conform, conform = pcall(require, "conform")
                                if has_conform then
                                    conform.format({ async = true })
                                else
                                    vim.lsp.buf.format({ async = true })
                                end
                            end,
                            mode = "n",
                            desc = "Format buffer",
                        },
                        { "<Leader>cl", "<cmd>LspInfo<CR>", mode = "n", desc = "Lsp info", },
                        { "<Leader>cwd", vim.lsp.buf.add_workspace_folder, mode = "n", desc = "Add Workspace folder", },
                        { "<Leader>cwr", vim.lsp.buf.remove_workspace_folder, mode = "n", desc = "Remove Workspace folder", },
                        { "<Leader>cw<CR>", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, mode = "n", desc = "List Workspace Folders", },
                    },
                },
                stylua = { enabled = false },
                clang = { enabled = true },
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            codeLens = {
                                enable = true,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            doc = {
                                privateName = { "^_" },
                            },
                            hint = {
                                enable = true,
                                arrayIndex = "Disable",
                                paramName = "Disable",
                                paramType = true,
                                setType = true,
                                semicolon = "Disable",
                            },

                        },
                    },
                },
            },
            -- setup = {
            --     -- example to setup with typescript.nvim
            --     -- tsserver = function(_, opts)
            --         --   require("typescript").setup({ server = opts })
            --         --   return true
            --         -- end,
            --         -- Specify * to use this function as a fallback for any server
            --         -- ["*"] = function(server, opts) end,
            --     },
            }

        end,
        -- config = function(_, opts)
        config = vim.schedule_wrap(function(_, opts)
            local utils = require("shiroryuu.utils")
            local lsp = require("shiroryuu.utils.lsp")

            require("fidget").setup({})

            -- Setup formatter

            -- setup keymaps
            for server, server_opts in pairs(opts.servers) do
                if type(server_opts) == "table" and server_opts.keys then
                    lsp.set_keymaps({ name = server ~= "*" and server or nil }, server_opts.keys)
                end
            end
            -- WARN: client.supports method is being depricated
            -- inlay_hints
            if opts.inlay_hints.enabled then
                lsp.on_attach(function(client, buffer)
                    if  vim.api.nvim_buf_is_valid(buffer)
                        and vim.bo[buffer].buftype == ""
                        and client.supports_method("textDocument/inlayHint")
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                        then
                            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                        end
                    end)
                end

            if opts.codelens.enabled and vim.lsp.codelens then
                lsp.on_attach(function(client, buffer)
                    if vim.api.nvim_buf_is_valid(buffer)
                        and vim.bo[buffer].buftype == ""
                        and client.supports_method("textDocument/codeLens")
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                        then
                            vim.lsp.codelens.refresh()
                            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                                buffer = buffer,
                                callback = vim.lsp.codelens.refresh,
                            })
                        end
                end)
            end

         vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

         if (opts.servers["*"]) then
             vim.lsp.config("*",opts.servers["*"])
         end

         -- Mason config
         local have_mason, mlsp = pcall(require, "mason-lspconfig.nvim")
         local mason_all = have_mason and
             vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map.lspconfig_to_package)
             or {}
        local mason_exclude = {}

        local ms_install = {}
        for server,server_opts in pairs(opts.servers) do
            server_opts = server_opts == true and {}
            or (not server_opts) and { enabled = false } or server_opts

            if server_opts.enabled == false then
                mason_exclude[#mason_exclude+1] = server
                return
            end
            local use_mason = server_opts.use_mason ~= false and vim.tbl_contains(mason_all, server)
            -- vim.lsp.enable(server)
            if use_mason then
                ms_install[#ms_install+1] = server
            end

        end

        if have_mason then
            require("mason-lspconfig").setup({
                ensure_install = ms_install,
                automatic_enable = { exclude = mason_exclude },
            })
        end
    end),
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_uninstalled = "✗",
                    package_pending = "⟳",
                },
            },
            ensure_installed = {
                "stylua",
                "selene",
                "shfmt",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    }
}
