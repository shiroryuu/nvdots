local options = {
    opt = {
        backup = false,                                     -- enabling this keeps the backup file made by 'writebackup' after overwriting
        clipboard = "",                                     -- disable system keyboard by default
        confirm = true,                                     -- confirm to save changes before exisiting modified buffer
        colorcolumn = "80",                                 -- a comma-separated list of screen columns that are highlighted with ColorColumn hl-ColorColumn.
        fileencoding = "utf-8",                             -- Default file encoding
        hlsearch = false,                                   -- highlight previous search pattern
        history = 250,                                      -- number of commands tto remember in a history table
        incsearch = true,                                   -- While typing a search command, highlight the matches.
        tabstop = 4,                                        -- Number of spaces that tab counts
        softtabstop = 4,                                    -- When on, inserts blanks infront of line, according to 'shiftwidth'
        shiftwidth = 4,                                     -- number of spaces to use for each step
        expandtab = true,                                   -- add tabs when tab is pressed in insert mode
        number = true,                                      -- line number
        relativenumber = true,                              -- relative LN
        scrolloff = 8,                                      -- Minimal number of screen lines to keep above and below the cursor.
        sidescrolloff = 8,                                  -- number of columns to keep around the cursor if 'nowrap' is set.
        smartindent = true,                                 -- Do smart autoindenting when starting a new line.
        signcolumn = "yes",                                 -- Always show sign column
        swapfile = false,                                   -- Disable creation of swap file
        termguicolors = true,                               -- 24bit color support in TUI
        timeoutlen = 500,                                   -- which-key timeout len default (1000)
        title = true,                                       -- set terminal title to filename and path
        undodir = os.getenv("XDG_STATE_HOME") .. "/nvim/undodir", -- List of directory names for undo files, separated with commas
        undofile = true,                                    -- When on, Vim automatically saves undo history to an undo file
        updatetime = 300,                                   -- length of time to wait before triggering the plugin
        virtualedit = "block",                              -- allow going past end of line in visual block mode
        wrap = false,                                       -- disable word wrap
        writebackup = true,                                 -- create a backup before overwriting a file
    },
    g = {
        mapleader = " ",
        maplocalleader = ",",
        max_file = { size = 1024 * 100, lines = 10000 },
        highlighturl_enabled = true,
        icons_enabled = true,

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

        loaded_netrw = 1,
        loaded_netrwPlugin = 1,
        loaded_netrwSettings = 1,
    },
}

vim.opt.isfname:append("@-@")
if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end

for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end
