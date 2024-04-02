local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = { lazy = true },
    lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
    performance = {
        rtp = {
            disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin"},
        },
   }
}

require("lazy").setup("plugins", opts)

--require("lazy").setup("lazy", {
--  spec = spec,
--  defaults = { lazy = true },
--  git = { filter = modern_git },
--  install = { colorscheme = colorscheme },
--  performance = {
--    rtp = {
--      paths = astronvim.supported_configs,
--      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
--    },
--  },
--  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
--})

