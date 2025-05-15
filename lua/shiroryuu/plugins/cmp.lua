local blink_from_main = false
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = blink_from_main and "*" or "1.*",
	-- need cargo to build from main
	build = blink_from_main and "cargo build --release",
	event = "InsertEnter",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = function()
		local cmp_icons = require("shiroryuu.utils.icon").get_icons("Kinds")

		return {
			cmdline = {
				-- Disabled for now as it throws lspkind not found error
				-- Also need to configure keymaps
				enabled = false,
			},
			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									-- local lspkind = require("lspkind")
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										if cmp_icons[ctx.kind] then
											icon = cmp_icons[ctx.kind]
										end
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},

			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			snippets = {
				preset = "luasnip",
			},
		}
	end,
	opts_extend = {
		"sources.default",
	},
	---@param opts blink.cmp.Config | { sources: { compat: string[] } }
	config = function(_, opts)
		local cmp_icons = require("shiroryuu.utils.icon").get_icons("Kinds")
		require("blink.cmp").setup(opts)
	end,
}
