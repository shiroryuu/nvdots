require("which-key")
local map = vim.keymap.set

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
map("n", "J", "mzj`z")

-- Cursor at the center of page while using C-d or C-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move word to void register
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", [["_d]])

-- Enable system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
