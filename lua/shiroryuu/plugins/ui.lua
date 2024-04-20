return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
        opts = function()
            local get_icon = require("shiroryuu.utils.icon").get_unicon
            return{
                plugins = { spelling = true },
                defaults = {
                    mode = { "n", "v" },
                    ["g"] = { name = "+goto" },
                    ["]"] = { name = "+next" },
                    ["["] = { name = "+prev" },
                    ["<M-Tab>"] = { get_icon("General", "Files", 1) .. "Open Buffers" },
                    ["<Leader>f"] = { get_icon("General", "Search", 1) .. "Find" },
                    ["<Leader>g"] = { get_icon("General", "Git", 1) .. "Git" },
                    ["<Leader>l"] = { get_icon("General", "LSP", 1) .. "LSP" },
                    ["<Leader>t"] = { get_icon("General", "Toggles", 2) .. "Toggles" },
                },
            }
        end,
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
	},
    -- TODO: Add REFR or REFS
    {
        "folke/todo-comments.nvim",
        event = "User LazyFile",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "folke/zen-mode.nvim",
        dependencies = { "folke/twilight.nvim" },
        keys = {
            { "<Leader>tz", "<Cmd>ZenMode<CR>", { desc = "Toggle Zen mode" } }
        },
        opts = {
            window = {
                backdrop = 1,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "no",
                    relativenumber = false,
                },
            },
        },
        config = function(_, opts)
            require("zen-mode").setup(opts)
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "BufEnter",
        opts = {
            stages = "static",
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        -- TODO: Add keys to dismiss
        init = function()
            vim.notify = require("notify")
        end,
    },
}
