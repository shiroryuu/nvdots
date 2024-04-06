vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Change the working directory to the current file",
  group = vim.api.nvim_create_augroup("autochdir_grp", { clear = true }),
  pattern = "*",
  command = "cd %:p:h",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("shiroryuu_highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("shiroryuu_lspattach", { clear = true }),
  callback = function(event)
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, { desc = "List LSP definition" })
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, { desc = "List LSP declaration" })
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.declaration()
    end, { desc = "List LSP definition" })

    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
  end,
})
