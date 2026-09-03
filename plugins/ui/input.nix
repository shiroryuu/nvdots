{ pkgs, ... }:
let
    miniInput-from-source = pkgs.vimUtils.buildVimPlugin {
        pname = "mini-input";
        version = "957991e";
        src = pkgs.fetchFromGitHub {
            owner = "nvim-mini";
            repo = "mini.input";
            rev = "957991e29b060dd74aad0b4098993dad313e09fa";
            hash = "sha256-r7DFaZhRtr7J7Pu7meMRko40Dvs9finb/t8NtqSbtgU=";
        };
    };
in {
    vim.lazy.plugins."mini-input" = {
        package = miniInput-from-source;
        setupModule = "mini.input";
        setupOpts = {
            ## Functions that control input lifecycle
            handlers = {
                ## Compute completion candidates
                complete = null;

                ## Compute highlighting of current input
                highlight = null;

                ## Handle input start, every key press, and input end
                key = null;

                ## Show current input state
                view = null;
            };

            ## Default input scope: cursor/line/buffer/window/tabpage/editor/project
            scope = "editor";
        };
        lazy = false;
        event = ["VimEnter"];
    };
}
