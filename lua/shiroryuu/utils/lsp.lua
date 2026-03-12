local M = {}

function M.get_clients(opts)
	return (vim.lsp.get_clients or vim.lsp.get_active_clients)({ opts })
end

function M.on_attach(fn)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			fn(client, buffer)
		end,
	})
end

function M.set_keymaps(filter, spec)
  local Keys = require("lazy.core.handler.keys")
  for _, keys in pairs(Keys.resolve(spec)) do
    ---@cast keys LazyKeysLsp
    local filters = {} ---@type vim.lsp.get_clients.Filter[]
    -- local snacks = require("snacks")
    if keys.has then
      local methods = type(keys.has) == "string" and { keys.has } or keys.has --[[@as string[] ]]
      for _, method in ipairs(methods) do
        method = method:find("/") and method or ("textDocument/" .. method)
        filters[#filters + 1] = vim.tbl_extend("force", vim.deepcopy(filter), { method = method })
      end
    else
      filters[#filters + 1] = filter
    end

    for _, f in ipairs(filters) do
      local opts = Keys.opts(keys)
      ---@cast opts snacks.keymap.set.Opts
      opts.lsp = f
      opts.enabled = keys.enabled
      Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
