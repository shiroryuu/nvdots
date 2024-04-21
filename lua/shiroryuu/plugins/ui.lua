return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
        opts = function()
            local get_icon = require("shiroryuu.utils.icon").get_unicon
            return{
                plugins = { spelling = true },
                icons = {
                    group = vim.g.icons_enabled ~= false and "" or "+",
                },
                defaults = {
                    mode = { "n", "v" },
                    ["g"] = { name = "+goto" },
                    ["gs"] = { name = "+surround" },
                    ["z"] = { name = "+fold" },
                    ["]"] = { name = "+next" },
                    ["["] = { name = "+prev" },
                    ["<M-Tab>"] = { get_icon("General", "Files", 1) .. "Open Buffers" },
                    ["<Leader>b"] = { get_icon("General", "Window", 1) .. "Buffer" },
                    ["<Leader>c"] = { get_icon("General", "Code", 1) .. "Code/LSP" },
                    ["<Leader>d"] = { get_icon("General", "Dap", 1) .. "Debugger" },
                    ["<Leader>e"] = { get_icon("General", "Folders", 1) .. "Neotree toggle" },
                    ["<Leader>f"] = { get_icon("General", "Search", 1) .. "Find" },
                    ["<Leader>h"] = { get_icon("General", "Window", 1) .. "Harpoon" },
                    ["<Leader>g"] = { get_icon("General", "Git", 1) .. "Git" },
                    ["<Leader>gh"] = { get_icon("Git", "Hunk", 1) .. "Hunk" },
                    ["<Leader>gg"] = { get_icon("General", "GitAlt", 1) .. "LazyGit" },
                    ["<Leader>p"] = { get_icon("General", "Arrow", 1) .. "Projects" },
                    ["<Leader>q"] = { get_icon("General", "Close", 1) .. "Quit" },
                    ["<Leader>t"] = { get_icon("General", "Toggles", 2) .. "Toggles" },
                    ["<Leader>w"] = { get_icon("General", "Save", 1) .. "Save" },
                    ["<Leader>x"] = { get_icon("General", "Diagnostics", 1) .. "Diagnostics" },
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
