require("which-key")
local map = vim.keymap.set

-- Normal Mode
map("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Explorer toggle" })
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
map("n", "<Leader>q", "<Cmd>confirm q<CR>", { desc = "Quit" })
