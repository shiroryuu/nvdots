{ lib, ... }:
let
    inherit (lib.generators) mkLuaInline;
    logo = ''
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
'';
in
{
    vim.dashboard.dashboard-nvim = {
        enable = true;
        setupOpts = {
            theme = "doom";    ## theme is doom and hyper default is hyper
            "@1" = "disable_move";       ## default is false disable move keymap for hyper
            "@2" = "shortcut_type";      ## shortcut type 'letter' or 'number'
            "@3" = "shuffle_letter";     ## default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
            "@4" = "letter_list";        ## default is a-z, excluding j and k
            "@5" = "change_to_vcs_root"; ## default is false,for open file in hyper mru. it will change to the root of vcs
            config = {
                header = lib.splitString "\n" logo;
                center = [
                    ## action can be a function type

                    {
                        icon = " ";
                        desc = "Empty buffer";
                        # ene | startinsert
                        action = "enew";
                        key = "e";
                    }
                    {
                        icon = " ";
                        icon_hl = "@variable";
                        desc = "Files";
                        group = "Label";
                        action = "Telescope find_files";
                        key = "f";
                    }
                    {
                        desc = " Apps";
                        group = "DiagnosticHint";
                        action = "Telescope app";
                        key = "a";
                    }
                    {
                        icon = " ";
                        desc = "dotfiles";
                        group = "Number";
                        # action = "Telescope vim.fn.getenv(DOTSLOC)";
                        action = mkLuaInline ''
                            function()
                                vim.fn.chdir(vim.fn.getenv("DOTSLOC") or ".")
                                vim.cmd("Telescope find_files")
                            end
                        '';
                        key = "d";
                    }
                    {
                        icon = " ";
                        desc = "NVF Config";
                        # group = "Number";
                        # TODO: Nix store nvf
                        # action = ":lua Snacks.explorer.open({ cwd = vim.fn.stdpath('config') })"
                        # action = "oil.open({cwd = vim.fn.getenv(DOTSLOC)})";
                        action = mkLuaInline ''
                            function()
                                vim.fn.chdir(vim.fn.getenv("DOTSLOC").."/nvdots"or ".")
                                vim.cmd("Telescope find_files")
                            end
                        '';
                        key = "c";
                    }
                    {
                        icon = " ";
                        desc = "Restore Session";
                        action = "Persisted load_last";
                        key = "r";
                    }
                    {
                        icon = " ";
                        desc = "Select Session";
                        action = "Persisted load";
                        key = "R";
                    }
                    {
                        icon = " ";
                        desc = "Quit";
                        group = "DashboardShortCut";
                        key = "q";
                        action = ":qa";
                    }
                ];
                packages = { enable = false; }; ## show how many plugins neovim loaded
                ## limit how many projects list, action when you press key or enter it will run this action.
                ## action can be a function type, e.g.
                ## action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
                # project = { enable = false; limit = 8; icon = "your icon"; label = ""; action = "Telescope find_files cwd="; };
                # mru = { enable = false; limit = 10; icon = "your icon"; label = ""; cwd_only = false; };
                project.enable = false;
                mru.enable = false;
                footer = [];
                vertical_center = true;
            };
            hide = {
                statusline = false;
                winbar = true;
                tabline = true;
            };
            # preview = [
            #     { "@1" = "command"; }          ## preview command
            #     { "@2" = "file_path"; }        ## preview file path
            #     { "@3" = "file_height"; }      ## preview file height
            #     { "@4" = "file_width"; }       ## preview file width
            # ];
        };
    };
}
