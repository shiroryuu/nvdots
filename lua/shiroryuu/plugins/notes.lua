return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        ft = "markdown",
        keys = {
            { "<leader>fn", "<Cmd>ObsidianQuickSwitch<CR>", desc = "Quickly switch to Obsidian note using ripgrep" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "Personal",
                    path = "~/Documents/PKM/Arvind's Vault/"
                }
            },
            picker = {
                -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                name = "telescope.nvim",
                -- Optional, configure key mappings for the picker. These are the defaults.
                -- Not all pickers support all mappings.
                note_mappings = {
                    -- Create a new note from your query.
                    new = "<C-x>",
                    -- Insert a link to the selected note.
                    insert_link = "<C-l>",
                },
                tag_mappings = {
                    -- Add tag(s) to current note.
                    tag_note = "<C-x>",
                    -- Insert a tag at the current location.
                    insert_tag = "<C-l>",
                },
            },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
        ft = "markdown",
    },
    {
        "selimacerbas/markdown-preview.nvim",
        dependencies = { "selimacerbas/live-server.nvim" },
        ft = "markdown",
        config = function()
            require("markdown_preview").setup({
                -- all optional; sane defaults shown
                instance_mode = "takeover",  -- "takeover" (one tab) or "multi" (tab per instance)
                port = 0,                    -- 0 = auto (8421 for takeover, OS-assigned for multi)
                open_browser = true,
                debounce_ms = 300,
            })
        end,
    },
    -- REMOVE: No Longer maintained
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     ft = { "markdown" },
    --     build = ':call mkdp#util#install()'
    -- }
}
