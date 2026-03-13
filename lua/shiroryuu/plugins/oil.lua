-- TODO: Set ceiling when going up directiory
-- TODO: Show git tracked hidden files
return {
	{
		"stevearc/oil.nvim",
        event = "VimEnter",
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
			{ "nvim-tree/nvim-web-devicons" },
		},
		cmd = "Oil",
         keys = {
            {"<Leader>e", function() require("oil").toggle_float()end, desc=""},
        },
        opts = {
            default_file_explorer = true,
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
        },
		config = function(_, opts)
            -- helper function to parse output
            local function parse_output(proc)
                local result = proc:wait()
                local ret = {}
                if result.code == 0 then
                    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
                        -- Remove trailing slash
                        line = line:gsub("/$", "")
                        ret[line] = true
                    end
                end
                return ret
            end

            -- build git status cache
            local function new_git_status()
                return setmetatable({}, {
                    __index = function(self, key)
                        local ignore_proc = vim.system(
                            { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
                            {
                                cwd = key,
                                text = true,
                            }
                        )
                        local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
                            cwd = key,
                            text = true,
                        })
                        local ret = {
                            ignored = parse_output(ignore_proc),
                            tracked = parse_output(tracked_proc),
                        }

                        rawset(self, key, ret)
                        return ret
                    end,
                })
            end
            local git_status = new_git_status()

            local view_opts = {
                view_options = {
                    is_hidden_file = function(name, bufnr)
                        local dir = require("oil").get_current_dir(bufnr)
                        local is_dotfile = vim.startswith(name, ".") and name ~= ".."
                        -- if no local directory (e.g. for ssh connections), just hide dotfiles
                        if not dir then
                            return is_dotfile
                        end
                        -- dotfiles are considered hidden unless tracked
                        if is_dotfile then
                            return not git_status[dir].tracked[name]
                        else
                            -- Check if file is gitignored
                            return git_status[dir].ignored[name]
                        end
                    end,
                    -- show_hidden = true,
                },}

            local opts = vim.tbl_deep_extend("force", opts, view_opts)

            -- Clear git status cache on refresh
            local refresh = require("oil.actions").refresh
            local orig_refresh = refresh.callback
            refresh.callback = function(...)
                git_status = new_git_status()
                orig_refresh(...)
            end

            -- extend table
            require('oil').setup(opts)
        end,
	},
}
