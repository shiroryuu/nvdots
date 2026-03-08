local map = vim.keymap.set

-- TODO: delete afterwards
-- map("n", "<leader>o", ":update<CR> :source<CR>")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":confirm q<CR>")
map("n", "n", "nzzzv", { desc = "Next search match (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })
map("n", "Q", "<nop>", { desc = "No Ex mode" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move lines up" })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move lines down" })
map("n", "J","mzJ`z", { desc = "Join lines (cursor fixed)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move down half page (cursor centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move up half page (cursor centered)" })

-- clipboard
map("x", "<leader>p", [["_dP]], { desc = "Paste into void register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete into void register" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<Leader>Y", [["+Y]], { desc = "Yank whole line to system clipboard" })

map("n", "<leader><leader>x", ":update<CR> :source<CR>", { desc = "Reload config" })

-- Buffers
-- map("n", "<leader>bc", function()
--
-- end)

map("n", "<leader>e", ":Explore<CR>", { desc = "Open Netrw" })
