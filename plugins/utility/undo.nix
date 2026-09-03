{
    vim.utility.undotree.enable = true;
    vim.keymaps = [
        {
            mode = [ "n" ];
            key = "<leader>tu";
            action = "<cmd>UndotreeToggle<CR>";
            desc = "Toggle UndoTree";
        }
    ];
}
