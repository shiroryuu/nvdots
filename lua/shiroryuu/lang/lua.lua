local M = {}

M.buf = 0

-- FIX: Fix formatting
local function format_on_save()
	-- TODO: Custom Keymaps
	local lsp = require("shiroryuu.utils.lsp")
	lsp.on_attach(function(client, bufnr)
		-- if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Shiroryuu_fos_python", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
		-- end
	end)
end

function M.setup()
	-- LSP
	local mason_nls_status, mason_nls = pcall(require, "mason-null-ls")
	local lspconfig_status, lspconfig = pcall(require, "lspconfig")
	local sources = { "stylua" }

	if mason_nls_status then
		mason_nls.setup({ ensure_installed = sources, automatic_installation = false })
	end

	if not lspconfig_status then
		vim.notify("lspconfig not found. Skipping Lua setup", vim.log.levels.WARN)
		return
	end

	-- Format on Save
	format_on_save()
end

return M

-- Pyhton Setup
--[[
function M.setup()
  -- Indentation
  vim.opt_local.tabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = true
  vim.opt_local.autoindent = true
  vim.opt_local.smartindent = true -- Adds some extra Python-aware indenting

  -- LSP Setup
  setup_lsp()

  -- Formatting Setup
  setup_formatting()

  -- Linting Setup
  setup_linting()

end
--]]
