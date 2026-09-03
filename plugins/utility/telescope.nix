{ lib, pkgs, inputs, ... }:
let
    inherit (lib.generators) mkLuaInline;
    actions = ''require("telescope.actions")'';
    builtin = ''require("telescope.builtin")'';
    mkMap = mode: key: action: opts: {
        inherit mode key action;
        noremap = true;
        silent = true;
    } // opts;
in
{
    vim.telescope = {
        enable = true;
        extensions = [
            {
                name = "fzf";
                packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
                setup = {fzf = {fuzzy = true;};};
            }
            {
                name = "ui-select";
                packages = [pkgs.vimPlugins.telescope-ui-select-nvim];
                # setup = {};
            }
        ];
        setupOpts.defaults = {
            layout_config.horizontal.prompt_position = "bottom";
            sorting_strategy = "descending";
            mappings = {
                i = {
                    "<C-n>" = mkLuaInline "${actions}.cycle_history_next";
                    "<C-p>" = mkLuaInline "${actions}.cycle_history_prev";
                    "<C-j>" = mkLuaInline "${actions}.move_selection_next";
                    "<C-k>" = mkLuaInline "${actions}.move_selection_previous";
                    # "<Esc>" = mkLuaInline "require('telescope.actions').close";
                };
                n = {
                    "<Esc>" = mkLuaInline "${actions}.close";
                    "q" = mkLuaInline "${actions}.close";
                };
            };
        };
    };

    # Thanks to @github:LuixBits for this tip
    # Neorg exposes telescope.nvim through pack/start, so requiring
    # Telescope can otherwise bypass NVF's lazy setup and its mappings.
    vim.luaConfigRC.telescope-configured = lib.nvim.dag.entryAfter [ "lazyConfigs" ] ''
          require("lz.n").trigger_load("telescope")
    '';

    vim.keymaps = [
        (mkMap "n" "<Leader>ff"
        ''function() ${builtin}.find_files({ follow = true, }) end''
        { desc = "Find Files"; lua = true ;})
        (mkMap "n" "<localleader>ff" ''
            function() 
                ${builtin}.find_files({ 
                    follow = true, 
                    find_command = { "${lib.getExe pkgs.ripgrep}", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" },
                }) end
        '' { desc = "Find Files(hidden)"; lua = true ;})
       (mkMap "n" "<leader>fg" ''
               function ()
                  ${builtin}.git_files()
               end
        '' { desc = "Find Git Files"; lua = true ;})
       (mkMap ["n" "x"] "<leader>fw" ''
               function ()
                local word = vim.fn.expand("<cword>")
                ${builtin}.grep_string({ search = word })
               end
        '' { desc = "Find Word"; lua = true ;})
       (mkMap ["n" "x"] "<leader>fW" ''
               function ()
                 local word = vim.fn.expand("<cword>")
                 ${builtin}.grep_string({
                     search = word,
                     additional_args = function()
                         return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                     end,
                 })
                 end
        '' { desc = "Find Word (hidden and ignored files)"; lua = true ;})
       (mkMap ["n" "x"] "<leader>fs" ''
               function ()
                local word = vim.fn.expand("<cWORD>")
                ${builtin}.grep_string({ search = word })
               end
        '' { desc = "Find String"; lua = true ;})
       (mkMap ["n" "x"] "<leader>fS" ''
               function ()
                 local word = vim.fn.expand("<cWORD>")
                 ${builtin}.grep_string({
                     search = word,
                     additional_args = function()
                         return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                     end,
                 })
                 end
        '' { desc = "Find String(hidden and ignored files)"; lua = true ;})
       (mkMap "n" "<leader>ft" ''
               function ()
                ${builtin}.colorscheme({ enable_preview = true })
               end
        '' { desc = "Find Themes"; lua = true ;})

        # Search
        (mkMap "n" "<Leader>sb" ''
            function() 
                ${builtin}.current_buffer_fuzzy_find({
                    previewer = false,
                    layout_strategy = 'vertical',
                    layout_config = {
                        anchor="S",
                        height = 0.5,
                        width = { padding = 5 },
                        prompt_position = 'top',
                    },
                })
            end
         '' { desc = "Search in Buffer(Current)"; lua = true ;})
        (mkMap "n" "<Leader>sB"
        ''function() ${builtin}.buffers() end''
        { desc = "Search Buffers"; lua = true ;})
        (mkMap "n" "<Leader>sc" ''
            function() 
                ${builtin}.command_history({
                       layout_strategy = 'vertical',
                       layout_config = {
                           anchor="N",
                           height = 0.5,
                           width = { 0.45, max = 55},
                           prompt_position = 'top',
                       },
                    })
                end
         '' { desc = "Search Command History"; lua = true ;})
        (mkMap "n" "<Leader>sh"
        ''function() ${builtin}.help_tags() end''
        { desc = "Search Help"; lua = true ;})
        (mkMap "n" "<Leader>sm"
        ''function() ${builtin}.man_pages() end''
        { desc = "Search Manpages"; lua = true ;})
        (mkMap "n" "<Leader>s/"
        ''function() ${builtin}.search_history() end''
        { desc = "Search History"; lua = true ;})
        (mkMap "n" "<localleader>sc"
        ''function() ${builtin}.spell_suggest() end''
        { desc = "Search Spellcheck"; lua = true ;})
        (mkMap ["n" "x"] "<Leader>sw"
        ''function() ${builtin}.live_grep() end''
        { desc = "Search Word"; lua = true ;})
        (mkMap "n" "<localleader>sw" ''
            function()
                ${builtin}.live_grep({
                   additional_args = function()
                       return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                   end,
                })
            end
        '' { desc = "Search Word (hidden and ignored files)"; lua = true ;})

        ## GIT
        (mkMap "n" "<Leader>gb"
        ''function() ${builtin}.git_branches() end''
        { desc = "Git Branches"; lua = true ;})
        (mkMap "n" "<Leader>gc"
        ''function() ${builtin}.git_commits() end''
        { desc = "Git Commits (Repo)"; lua = true ;})
        (mkMap "n" "<Leader>gC"
        ''function() ${builtin}.git_bcommits() end''
        { desc = "Git Commits (Current File)"; lua = true ;})
        (mkMap "n" "<Leader>gd"
        ''function() vim.notify("TODO") end''
        { desc = "Git Commits (Current File)"; lua = true ;})
        (mkMap "n" "<Leader>gs"
        ''function() ${builtin}.git_status() end''
        { desc = "Git Status"; lua = true ;})

        ## LSP
        (mkMap "n" "gd"
        ''function() ${builtin}.lsp_definitions() end''
        { desc = "Goto Definition"; lua = true ;})
        (mkMap "n" "gD"
        ''function() ${builtin}.lsp_declarations() end''
        { desc = "Goto Declaration"; lua = true ;})
        (mkMap "n" "gr"
        ''function() ${builtin}.lsp_references() end''
        { desc = "Goto Reference"; lua = true ;})
        (mkMap "n" "gI"
        ''function() ${builtin}.lsp_implementations() end''
        { desc = "Goto Implementation"; lua = true ;})
        (mkMap "n" "gy"
        ''function() ${builtin}.lsp_type_definitions() end''
        { desc = "Goto T[y]pe Definition"; lua = true ;})
    ];
}
