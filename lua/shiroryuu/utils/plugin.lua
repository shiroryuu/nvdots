local M = {}

function M.is_available(plugin)
	local lazy_config_ok, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_ok and lazy_config.spec.plugin[plugin] ~= nil
end

function M.get_opts(plugin_name)
    local lazy_plugins_ok, lazy_plugins = pcall(require, "lazy.core.config")
    if lazy_config_ok then
        local plugin = lazy_plugins.plugins[plugin_name]
        if not plugin then return {} end
        return require("lazy.core.plugin").values(plugin, "opts", false)
    else return {} end
end

function M.on_load(plugins, load_pkg)
    local lazy_config_ok, lazy_config = pcall(require, "lazy.core.config")
    if lazy_config_ok then
        if type(plugins) == "string" then plugins = { plugins } end
        if type(load_pkg) ~= "function" then
            local to_load = type(load_pkg) == "string" and { load_pkg } or load_pkg
            load_pkg = function() require("lazy").load({ plugins = to_load }) end
        end
        for _, plugin in ipairs(plugins) do
            if vim.tbl_get(lazy_config.plugins, plugin, "_", "loaded") then
                vim.schedule(load_pkg)
                return
            end
        end
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            desc = ("A function to be ran when one of these plugins runs: %s"):format(vim.inspect(plugins)),
            callback = function(args)
                if vim.tbl_contains(plugins, args.data) then
                    load_pkg()
                    return true
                end
            end,
        })
    end
end

return M
