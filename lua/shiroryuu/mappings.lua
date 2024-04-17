require("which-key")
local map = vim.keymap.set

--    TODO: Bootstrap mappings
--    sections from astronvim (https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/_astrocore_mappings.lua)
--    opts._map_sections = {
--      f = { desc = get_icon("Search", 1, true) .. "Find" },
--      p = { desc = get_icon("Package", 1, true) .. "Packages" },
--      l = { desc = get_icon("ActiveLSP", 1, true) .. "Language Tools" },
--      u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
--      b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
--      bs = { desc = get_icon("Sort", 1, true) .. "Sort Buffers" },
--      d = { desc = get_icon("Debugger", 1, true) .. "Debugger" },
--      g = { desc = get_icon("Git", 1, true) .. "Git" },
--      h = { desc = get_icon("Harpoon", 1, true) .. "Harpoon" },
--      S = { desc = get_icon("Session", 1, true) .. "Session" },
--      t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
--    }


-- Toggleable UIs
map("n", "<Leader>tb", function()
	local utils = require("shiroryuu.utils")
	utils.toggle_background()
end, { desc = "Toggle Theme background (Dark/Light)" })

-- Normal Mode
map("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Explorer toggle" })
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
map("n", "<Leader>q", "<Cmd>confirm q<CR>", { desc = "Quit" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "Q", "<nop>")

-- Visual Mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- cursor wont move when using J
map("n", "J", "mzJ`z")

-- Cursor at the center of page while using C-d or C-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move word to void register
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- Enable system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
