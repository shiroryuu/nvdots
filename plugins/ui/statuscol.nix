{ inputs, pkgs, lib, ... }:
let
    ministatus-from-source = pkgs.vimUtils.buildVimPlugin {
        name = "mini-statuscol";
        src = pkgs.fetchFromGitHub {
            owner = "nvim-mini";
            repo = "mini.statuscolumn";
            rev = "a7e533119f2cb5e4dcbaa584c308089d94c51f99";
            hash = "sha256-W7Moiup/m2UirDpqU3veVYDVadJtXNW8QSy6nOw35Wk=";
        };
    };
in {
    # vim.lazy.plugins."vimplugin-mini-statuscol" = {
    #   package = ministatus-from-source;
    #   setupModule = "mini.statuscolumn";
    #   setupOpts = {};
    # lazy = false;
    # event = ["BufEnter"];
    # event = [
    #   {
    #     event = "User";
    #     pattern = "LazyFile";
    #   }
    # ];
    # };
    vim.extraPlugins = {
        mini-statuscol = {
            package = ministatus-from-source;
            setup = ''
            local statuscolumn = require('mini.statuscolumn')
            local specs = {
                  -- Prefer visible separator with a more efficient order to use
                  -- usually present whitespace to the right of signs
                  -- { format = '=lfs', sep = '▍' },
                  -- { format='=fsl', sep='│' },
                  { format='fs=l', sep='│' },
                  -- { format='f=ls', sep='│' },
                  { pos = 'cursor', sep = '▍' },
                  -- Use custom symbol for virtual lines
                  { ltype = 'virt', lnum = '•' },
                  -- Use custom symbol for wrapped lines
                  { ltype = 'wrap', lnum = '↳' },
                  -- Hide separator to better indicate inactive windows
                  { win = 'inactive', sep = ' ' },
               }
               require('mini.statuscolumn').setup({ content = statuscolumn.gen_content.main(specs) })
            '';
        };
    };
}
