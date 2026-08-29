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
    vim.navigation.harpoon = {
        enable = true;
        mappings = {
            file1 = "<C-h>";
            file2 = "<C-t>";
            file3 = "<C-n>";
            file4 = "<C-s>";
            listMarks = "<leader>ha";
            markFile = "<leader>hl";
        };
    };
    vim.utility.undotree.enable = true;
    vim.keymaps = [
        (mkMap "n" "<leader>tu" "<cmd>UndotreeToggle<CR>" { desc = "Toggle UndoTree"; })
    ];
}
