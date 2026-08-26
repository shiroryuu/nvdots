{ lib, ... }: let
    inherit (lib.generators) mkLuaInline;
in {
    vim.augroups = [ { name = "UserSetup"; } ];
    vim.autocmds = [
        {
            desc = "Enable wrap and spellcheck for text like documents";
            event = [ "FileType" ];
            group = "UserSetup";
            pattern = [
                "gitcommit"
                "markdown"
                "text"
                "norg"
                "plaintex"
                "groff"
            ];
            callback = mkLuaInline ''
               function(event)
                    vim.opt_local.wrap = true
                    vim.opt_local.spell = true
                    vim.opt_local.linebreak = true
                    vim.opt_local.conceallevel = 2
                    vim.opt_local.breakindent = true
                    vim.opt_local.signcolumn = "no"
                    vim.keymap.set('n', 'k', 'gk', { noremap = true, buffer = event.buf })
                    vim.keymap.set('n', 'j', 'gj', { noremap = true, buffer = event.buf })
                end
            '';
        }
        {
            desc = "Close files with q";
            event = [ "FileType" ];
            pattern = [
                "PlenaryTestPopup"
                "help"
                "lspinfo"
                "notify"
                "oil"
                "qf"
                "query"
                "fugitive"
                "spectre_panel"
                "startuptime"
                "tsplayground"
                "neotest-output"
                "checkhealth"
                "neotest-summary"
                "neotest-output-panel"
            ];
            group = "UserSetup";
            callback = mkLuaInline ''
                function(event)
                   vim.bo[event.buf].buflisted = false
                   vim.keymap.set("n", "q", vim.cmd.close, { buffer = event.buf, silent = true })
                end
            '';
        }
        {
            desc = "Highlight the yanked text";
            event = [ "TextYankPost" ];
            group = "UserSetup";
            callback = mkLuaInline ''
                function ()
                    if vim.fn.has("nvim-0.11") then
                        vim.hl.on_yank()
                    end
                end
            '';
        }
        {
            desc  = "Maximize size";
            event = [ "BufWinEnter" ];
            group = "UserSetup";
            pattern = [
                "*.txt"
                "fugitive://*"
            ];
            callback = mkLuaInline ''
                  function (event)
                      local ft = vim.bo[event.buf].filetype
                      if ft == "help" or ft == "fugitive" then
                          vim.bo[event.buf].buflisted = false
                          vim.cmd('wincmd T')
                      end
                  end
            '';
        }
        {
            desc = "Disable Trailspace for the filetype";
            event = [ "FileType" ];
            group = "UserSetup";
            pattern = [ "snacks_dashboard" "dashboard" ];
            callback = mkLuaInline ''
                function()
                    vim.b.minitrailspace_disable = true
                end
            '';

        }
    ];
}
