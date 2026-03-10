-- TODO: Cleanup comments
-- TODO: mv to lazydev
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true, lazy = true, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim", opts = {} },
            { "stevearc/conform.nvim" },
            { "williamboman/mason.nvim", },
			{
                "williamboman/mason-lspconfig.nvim",
				cmd = { "LspInstall", "LspUninstall" },
				init = function(plugin)
					require("shiroryuu.utils.plugin").on_load("mason.nvim", plugin.name)
				end,
				opts = {},
			},
			{ "j-hui/fidget.nvim", opts = {} },
		},
		event = "User LazyFile",
		cmd = function(_, cmds)
			if require("shiroryuu.utils.plugin").is_available("neoconf.nvim") then
				table.insert(cmds, "Neoconf")
			end
			vim.list_extend(cmds, { "LspInfo", "LspLog", "LspStart" })
		end,
		opts = function()
			local lsp_icons = require("shiroryuu.utils.icon").get_icons("Diagnostics", 1)
			return {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = lsp_icons.Error,
							[vim.diagnostic.severity.WARN] = lsp_icons.Warn,
							[vim.diagnostic.severity.HINT] = lsp_icons.Hint,
							[vim.diagnostic.severity.INFO] = lsp_icons.Info,
						},
					},
				},
				-- TODO: Use global options to set the value for inlay and codelens like setting
				-- up a function in options.lua which checks if nvim >= 10 condn

				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = true,
				},
				-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the code lenses.
                -- DONE:Setup LSP for CodeLens
                codelens = {
                    enabled = true,
                },
                document_highlight = {
                    enabled = true,
                },
                -- add any global capabilities here
                capabilities = {},

				-- TODO: Need to configure this as LazyVim has its own setup....
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				-- LSP Server Settings
				---@type lspconfig.options
                ---@diagnostic disable: missing-fields
				servers = {
	                lua_ls = {
		                ---@type LazyKeysSpec[]
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
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			}
		end,
		config = function(_, opts)
			local utils = require("shiroryuu.utils")
			local lsp = require("shiroryuu.utils.lsp")

            -- TODO: Config formatter

            -- set keymaps
            lsp.on_attach(function(client, buffer)
                require("shiroryuu.plugins.lsp.keymaps").on_attach(client, buffer)
            end)

            -- diagnostics signs
            if vim.fn.has("nvim-0.10") == 0 then
                for severity, icon in pairs(opts.diagnostics.signs.text) do
                    local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
                    name = "DiagnosticSign" .. name
                    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                end
            end

            if vim.fn.has("nvim-0.10") == 1 then
                if opts.inlay_hints.enabled then
                    lsp.on_attach(function(client, buffer)
                        -- TODO: Change client.supports_method as some bugs are reported in Lazyvim (need create an API)
                        -- REFR: https://github.com/LazyVim/LazyVim/issues/3246
                        if client.supports_method("textDocument/inlayHint") then
                            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                        end
                    end)
                end

                if opts.codelens.enabled and vim.lsp.codelens then
                    lsp.on_attach(function(client, buffer)
                        if client.supports_method("textDocument/codeLens") then
                            vim.lsp.codelens.refresh()
                            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                                buffer = buffer,
                                callback = vim.lsp.codelens.refresh,
                            })
                        end
                    end)
                end
            end

			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10") == 0 and "●"
					or function(diagnostic)
						local icons = require("shiroryuu.util.icon").get_icons("Diagnostics", 1)
						for d, icon in pairs(icons) do
							if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
								return icon
							end
						end
					end
			end
			vim.diagnostic.config(vim.deepcopy(opts.diagnostic))
			local servers = opts.servers
            local has_blink, blink = pcall(require, 'blink.cmp')
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
                has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                -- TODO: need to check
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed, automatic_installation = false, handlers = { setup } })
			end
		end,
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
    },
}
