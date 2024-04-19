local M = {}

M.icon_pack = nil

function M.init()
    local have_icons, icons = pcall(require, "shiroryuu.icons")
    if not have_icons then 
        M.icon_pack = " " 
        return 
    end
    M.icon_pack = icons
end

function M.get_icons(kind, padding, nofallback)
    local icons_enabled = vim.g.icons_enabled ~= false
    if not icons_enabled and nofallback then return "" end
    local icon = icon_pack[kind]
    return icon and icon .. (" "):rep(padding or 0) or ""
end
