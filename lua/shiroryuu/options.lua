local options = {
	opt = {
		autowrite = false,
		backup = false,
		clipboard = "",
		confirm = true,
		fileencoding = "utf-8",
		-- formatexpr = "v:lua.require'shiroryuu.util'.format.formatexpr()",
		foldlevel = 99,
        fillchars = {
            foldopen = "",
            foldclose = "",
            fold = " ",
            foldsep = " ",
            diff = "╱",
            eob = " ",
        },
		foldmethod = "expr",
		foldexpr = "v:lua.require'shiroryuu.util'.ui.foldexpr()",
		foldtext = "",
		hlsearch = false,
		history = 250,
		incsearch = true,
		tabstop = 4,
		shiftwidth = 4,
		number = true,
		cmdheight = 0,
		relativenumber = true,
		scrolloff = 8,
		sidescrolloff = 8,
		signcolumn = "yes",
		smoothscroll = true, -- vim >= 0.10
		-- statuscolumn = [[%!v:lua.require'shiroryuu.utils.ui'.statuscolumn()]],
		termguicolors = true,
		title = true,
		undodir = vim.fn.stdpath("state") .. "/undodir",
		undofile = true,
		undolevels = 10000,
		virtualedit = "block",
		wrap = false,
		writebackup = true,
		winborder = "rounded",
	},
	g = {
		mapleader = " ",
		maplocalleader = ",",
		theme_name= "kanagawa",
		theme_variant = "dragon",
		netrw_browse_split = 0,
		netrw_banner = 0,
		netrw_winsize = 25,

		-- Disable
		loaded_gzip = 1,
		loaded_zip = 1,
		loaded_zipPlugin = 1,
		loaded_tar = 1,
		loaded_tarPlugin = 1,

		loaded_getscript = 1,
		loaded_getscriptPlugin = 1,
		loaded_vimball = 1,
		loaded_vimballPlugin = 1,
		loaded_2html_plugin = 1,

		loaded_matchit = 1,
		loaded_matchparen = 1,
		loaded_logiPat = 1,
		loaded_rrhelper = 1,

		-- loaded_netrw = 1,
		-- loaded_netrwPlugin = 1,
		-- loaded_netrwSettings = 1,
	},
}
for scope, table in pairs(options) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end

-- load icons if enabled
if vim.g.icons_enabled ~= false then
    local icons = require("shiroryuu.utils.icon")
    icons.init()
end
