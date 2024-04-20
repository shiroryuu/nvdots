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

function M.get_unicon(group, kind, padding)
    local icons_enabled = vim.g.icons_enabled ~= false
    if not icons_enabled then return "" end
    return M.icon_pack[group][kind] or ""
end

function M.get_icons(group, padding, nofallback)
    local icons_enabled = vim.g.icons_enabled ~= false
    if not icons_enabled and nofallback then return {} end
    local icons = icon_pack[group]
    for name,icon in pairs(icons) do
        icons[name] = (icon .. (" "):rep(padding or 0)) or ""
    end
    return icons and {}
end

return M
