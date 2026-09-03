{...}:
let
    # Your mkMap function from earlier
    mkMap = mode: key: action: opts: {
        inherit mode key action;
        noremap = true;
        silent = true;
    } // opts;
in
{
    vim.utility.oil-nvim.enable = true;
    vim.utility.oil-nvim.gitStatus.enable = true;
    vim.keymaps = [
        (mkMap "n" "<Leader>e" "<cmd>lua require('oil').toggle_float()<CR>" { desc = "Toggle Oil"; })
    ];

    vim.luaConfigRC.oil-nvim = ''
        -- Your exact internal keymaps and options
        local opts = {
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
        }

        -- Your exact git status helper functions
        local function parse_output(proc)
            local result = proc:wait()
            local ret = {}
            if result.code == 0 then
                for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
                    line = line:gsub("/$", "")
                    ret[line] = true
                end
            end
            return ret
        end

        local function new_git_status()
            return setmetatable({}, {
                __index = function(self, key)
                    local ignore_proc = vim.system(
                        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
                        { cwd = key, text = true }
                    )
                    local tracked_proc = vim.system(
                        { "git", "ls-tree", "HEAD", "--name-only" }, 
                        { cwd = key, text = true }
                    )
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
                    if not dir then
                        return is_dotfile
                    end
                    if is_dotfile then
                        return not git_status[dir].tracked[name]
                    else
                        return git_status[dir].ignored[name]
                    end
                end,
            },
        }

        opts = vim.tbl_deep_extend("force", opts, view_opts)

        local refresh = require("oil.actions").refresh
        local orig_refresh = refresh.callback
        refresh.callback = function(...)
            git_status = new_git_status()
            orig_refresh(...)
        end

        -- Execute the final setup override
        require('oil').setup(opts)
    '';
}
