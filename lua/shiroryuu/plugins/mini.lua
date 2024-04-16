return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
        require("mini.ai").setup({ n_lines = 500 })
        require("mini.surround").setup()
        require("mini.indentscope").setup()
        require("mini.trailspace").setup()

        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = vim.g.icons_enabled ~= false }) -- icon
        statusline.section_location = function()
            return '%2l:%-2v'
        end
    end,
}
