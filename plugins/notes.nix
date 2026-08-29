{
    vim.notes.neorg= {
        enable = true;
        treesitter.enable = true;
        setupOpts = {
            load."core.defaults".enable = true;
            load."core.concealer".enable = true;
            load."core.dirman" = {
                enable = true;
                config = {
                    workspaces = {
                        notes = "~/Documents/neorg";
                    };
                    default_workspace = "notes";
                };

            };
        };
        # TODO: setupOpts
    };
    vim.keymaps = [
        {
            key = "<leader>fN";
            action = ''
                function()
                    local neorg = require('neorg');
                    local dirman = neorg.modules.get_module("core.dirman")
                    local workspace = dirman.get_default_workspace()
                    local note = dirman.index
                    local dir = tostring(dirman.get_workspace(workspace))
                    require("telescope.builtin").find_files({ cwd = dir })
                end
            '';
            mode = ["n"];
            desc = "Goto neorg index";
            lua = true;
        }
        {
            key = "<leader>ni";
            action = "<Cmd>Neorg index<CR>";
            mode = ["n"];
            desc = "Goto neorg index";
        }
    ];
}
