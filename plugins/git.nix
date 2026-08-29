{ ... }:{
    vim.git.enable = true;
    vim.git.gitsigns = {
        enable = true;
        mappings = {
            blameLine = "<leader>ghb";
            diffProject = "<leader>ghD";
            diffThis = "<leader>ghd";
            nextHunk = "]h";
            previewHunk = "<leader>ghp";
            previousHunk = "[h";
            resetBuffer = "<leader>ghR";
            resetHunk = "<leader>ghr";
            stageBuffer = "<leader>ghS";
            stageHunk = "<leader>ghs";
            undoStageHunk = "<leader>ghu";
        };
    };
    vim.git.vim-fugitive.enable = true;
    # FIX: The option `vim.git.octo-nvim' does not exist
    # vim.git.octo-nvim.enable = true;
    vim.keymaps = [
        {
            key = "<leader>lg";
            mode = ["n"];
            action = "<Cmd>Git<CR>";
            silent = true;
            desc = "Open Fugitive";
        }
    ];
}
