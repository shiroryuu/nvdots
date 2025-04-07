local map = vim.keymap.set

-- Auto Compile
map("n", "<Leader>ac", function()
	local utils = require("shiroryuu.utils")
    local current_file = vim.api.nvim_buf_get_name(0)
	-- local folder = vim.fn.fnamemodify(current_file, ":p:h")
    vim.notify("Compiling " .. current_file, "info")
    utils.exec_sys_cmd({ "compiler" , current_file }, false)
    -- print("Filename is " .. current_file)
end, { desc = "Autocompile targets (Mostly latex and markdown)" })
map("n", "<Leader>ao", function()
    -- DONE: Open compiled outpus
    local utils = require("shiroryuu.utils")
    local current_file = vim.api.nvim_buf_get_name(0)
    utils.exec_sys_cmd({ "opout" , current_file }, false)
end, { desc = "Open compiled outputs" })

-- Buffer Management
-- TODO: Add Buffer sorting and pick to close (maybe?)
map("n", "<Leader>bc", function()
	require("shiroryuu.utils.buffer").close_all(true)
end, { desc = "Close all buffers except the current one" })
map("n", "<Leader>bC", function()
	require("shiroryuu.utils.buffer").close_all()
end, { desc = "Close all buffers" })
map("n" , "<Leader>bd", function()
    require("shiroryuu.utils.buffer").close()
end, { desc = "Close current buffer" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

map("n", "<Leader>cd", function()
	vim.diagnostic.open_float()
end, { desc = "Hover diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Toggleable UIs
map("n", "<Leader>tb", function()
	local toggles = require("shiroryuu.utils.toggles")
	toggles.toggle_background()
end, { desc = "Toggle Theme background (Dark/Light)" })

-- Explorer
-- map("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Explorer toggle" })
-- Oil.nvim
map("n", "<Leader>e", function()
    require("oil").toggle_float()
end, { desc = "Explorer Toggle (Oil)" })

-- TODO: Change this shortcut
map("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save" })
map("n", "<Leader>q", "<Cmd>confirm q<CR>", { desc = "Quit" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "Q", "<nop>")

-- Visual Mode
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })

-- cursor wont move when using J
map("n", "J", "mzJ`z", { desc = "Joint Line" })

-- Cursor at the center of page while using C-d or C-u
map("n", "<C-d>", "<C-d>zz", { desc = "Move down half page (cursor centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move up half page (cursor centered)" })

-- Move word to void register
map("x", "<Leader>p", [["_dP]], { desc = "Paste into void register" })
map({ "n", "v" }, "<Leader>d", [["_d]], { desc = "Delete into void register" })

-- Enable system clipboard
map({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<Leader>Y", [["+Y]], { desc = "Yank whole line to system clipboard" })
