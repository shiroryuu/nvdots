return {
    {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-tree/nvim-web-devicons", opts = {} },
        },
        lazy = false,
        cmd = "Telescope",
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    mappings = {
                        i = {
                            ["<c-n>"] = actions.cycle_history_next,
                            ["<c-p>"] = actions.cycle_history_prev,
                            ["<c-j>"] = actions.move_selection_next,
                            ["<c-k>"] = actions.move_selection_previous,
                        },
                        n = { q = actions.close, },
                    },
                },
            }
        end,
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                -- Find
                {
                    "<leader>ff",
                    function()
                        builtin.find_files({
                            follow = true,
                        })
                    end,
                    desc = "Find Files",
                },
                {
                    "<localleader>f",
                    function()
                        builtin.find_files({
                            follow = true,
                            find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" },
                        })
                    end,
                    desc = "Find Files",
                },
                {
                    "<leader>fg",
                    function ()
                       builtin.git_files()
                    end,
                    mode = "n",
                    desc = "Find Git Files",
                },
                {
                    "<Leader>fw",
                    function()
                        local word = vim.fn.expand("<cword>")
                        builtin.grep_string({ search = word })
                    end,
                    mode = { "n", "x"},
                    desc = "Find Word",
                },
                {
                    "<Leader>fW",
                    function()
                        local word = vim.fn.expand("<cword>")
                        builtin.grep_string({
                            search = word,
                            additional_args = function()
                                return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                            end,
                        })
                    end,
                    mode = { "n", "x"},
                    desc = "Find Word in all files (hidden and ignored)",
                },
                {
                    "<Leader>fs",
                    function()
                        local word = vim.fn.expand("<cWORD>")
                        builtin.grep_string({ search = word })
                    end,
                    mode = { "n", "x"},
                    desc = "Find String",
                },
                {
                    "<Leader>fS",
                    function()
                        local word = vim.fn.expand("<cWORD>")
                        builtin.grep_string({
                            search = word,
                            additional_args = function()
                                return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                            end,
                        })
                        builtin.grep_string({ search = word })
                    end,
                    mode = {"n", "x"},
                    desc = "Find String",
                },

                {
                    "<leader>ft",
                    function()
                        builtin.colorscheme({ enable_preview = true })
                    end,
                    mode = "n",
                    desc = "Find Themes",
                },
                {
                    "<leader>sb",
                    function()
                        builtin.current_buffer_fuzzy_find({
                            previewer = false,
                            layout_strategy = 'vertical',
                            layout_config = {
                                anchor="S",
                                height = 0.5,
                                width = { padding = 5 },
                                prompt_position = 'top',
                            },
                        })
                    end,
                    mode = "n",
                    desc = "Search Current Buffer",
                },
                {
                    "<leader>sB",
                    function()
                        builtin.buffers()
                    end,
                    mode = "n",
                    desc = "Search Buffers",
                },
                {
                    "<leader>sc",
                    function()
                        builtin.command_history({
                            layout_strategy = 'vertical',
                            layout_config = {
                                anchor="N",
                                height = 0.5,
                                width = { 0.45, max = 55},
                                prompt_position = 'top',
                            },
                        })
                    end,
                    mode = "n",
                    desc = "Search Command History",
                },
                {
                    "<leader>sh",
                    function()
                        builtin.help_tags()
                    end,
                    mode = "n",
                    desc = "Help Pages",
                },
            {
                "<leader>sm",
                function()
                    builtin.man_pages()
                end,
                desc = "Man Pages",
            },
                {
                    "<leader>s/",
                    function()
                        builtin.search_history()
                    end,
                    mode = "n",
                    desc = "Search History",
                },
                {
                    "<leader>sw",
                    function()
                        builtin.live_grep()
                    end,
                    desc = "Search Word",
                    mode = "n",
                },
                -- TODO : spellcheck list
                {
                    "<localleader>sc",
                    function()
                        builtin.spell_suggest()

                    end,
                    desc = "Show Spellcheck",
                    mode = {"n", "x"},
                },
                {
                    "<localleader>sw",
                    function()
                        builtin.live_grep({
                            additional_args = function()
                                return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                            end,
                        })
                    end,
                    desc = "Search String",
                    mode = "n",
                },

                -- Git
                {
                    "<leader>gs",
                    function ()
                        builtin.git_status()
                    end,
                    mode = "n",
                    desc = "Git Status"
                },
                {
                    "<leader>gb",
                    function ()
                        builtin.git_branches()
                    end,
                    desc = "Git Branches",
                },
                {
                    "<leader>gc",
                    function ()
                        builtin.git_commits()
                    end,
                    desc = "Git Commits (Repo)",
                },
                {
                    "<leader>gC",
                    function ()
                        builtin.git_bcommits()
                    end,
                    desc = "Git Commits (Current File)"
                },
                {
                    "<leader>gd",
                    function ()
                        vim.notify("Git Diff TODO")
                    end,
                    desc = "Git Diff",
               },
            }
        end
    }
}
