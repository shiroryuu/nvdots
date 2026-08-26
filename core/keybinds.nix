{ config, ... }:
let
    mkMap = mode: key: action: opts: {
        inherit mode key action;
        noremap = true;
        silent = true;
    };
in
    {
        config.vim.keymaps = [
            (mkMap "n" "<leader>w" ":w<CR>" {})
            (mkMap "n" "<leader>q" ":confirm q<CR>" {})
            (mkMap "n" "n" "nzzzv" {desc = "next search match (centered)";})
            (mkMap "n" "n" "nzzzv" {desc = "previous search match (centered)";})
            (mkMap "n" "Q" "<nop>" {desc = "No Ex mode";})

            (mkMap "n" "<C-d>" "<C-d>zz" {desc = "Move down half page (cursor centered)";})
            (mkMap "n" "<C-u>" "<C-u>zz" {desc = "Move up half page (cursor centered)";})

            ## Line Manipulation
            (mkMap "n" "J" "mzJ`z" {desc = "Join lines (cursor fixed)";})
            (mkMap "v" "K" ":m '<-2<CR>gv=gv" {desc = "Move line up";})
            (mkMap "v" "J" ":m '>+1<CR>gv=gv" {desc = "Move lines down";})
            (mkMap "x" "<leader>p" ''"_dP'' { desc = "Paste into void register";})
            (mkMap "n" "<Leader>Y" ''"+Y'' { desc = "Yank whole line to system clipboard";})
            (mkMap [ "n" "v" ] "<leader>d" ''"_d'' { desc = "Delete into void register";})
            (mkMap [ "n" "v" ] "<leader>y" ''"+y'' { desc = "Yank to system clipboard";})
        ];
    }
