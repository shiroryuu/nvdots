vim.g.mapleader = " "
vim.g.maplocalleader = ", "

-- Disable builtin plugins
require("shiroryuu.disable_builtins")

-- Need to set leader and localleader before loading lazy
require("shiroryuu.lazy")
-- Pass theme from here 
require("shiroryuu.set_defaults")
require("shiroryuu.colorscheme")


-- vim.notify("Test Notification")
