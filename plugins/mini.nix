{config,...}:
# let
#     mini = config.vim.mini;
# in
{
   vim.mini.ai.enable = true;
   vim.mini.ai.setupOpts = { n_lines = 500; };
   vim.mini.surround.enable = true;
   vim.mini.icons.enable = true;
   vim.mini.indentscope.enable = true;
   vim.mini.trailspace.enable = true;
   vim.mini.statusline.enable = true;
   # vim.mini.statusline.setupOpts = {
   #      use_icons = true;
   #      content = { };
   #  };
    vim.luaConfigRC.mini = ''
    -- Since other mini modules are enabled, the package is installed.
    -- We can safely require and configure statusline manually.
    local statusline = require("mini.statusline")

    -- Assuming your ui.lua utility file is sourced (see Pro-Tip below)
    -- local utils_ui = require("shiroryuu.utils.ui")
    local recordingStatus = function()
    if not (vim.fn.reg_recording() ~= "") then return "" end
    --local icon = get_icon("General", "Recording", 1)
    local prefix = "@"
    local register = vim.fn.reg_recording()
    return  "Recording " .. prefix .. register
    end

    local mini_status_active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git           = MiniStatusline.section_git({ trunc_width = 40 })
        local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location      = "%2l:%-2v"
        local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
        local macro         = recordingStatus()

        return MiniStatusline.combine_groups({
            { hl = mode_hl,                  strings = { mode, macro } },
            { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl,                  strings = { search, location } },
        })
    end

    statusline.setup({
        use_icons = vim.g.icons_enabled ~= false,
        content = { active = mini_status_active },
    })
  '';
}
