{
    lib,
    pkgs,
    ...
}:{
    vim.undoFile.enable = true;
    vim.undoFile.path = "";

    vim.globals = {
        mapleader = " ";
        maplocalleader = ",";
        loaded_gzip = 1;
		loaded_zip = 1;
		loaded_zipPlugin = 1;
		loaded_tar = 1;
		loaded_tarPlugin = 1;

		loaded_getscript = 1;
		loaded_getscriptPlugin = 1;
		loaded_vimball = 1;
		loaded_vimballPlugin = 1;
		loaded_2html_plugin = 1;

		loaded_matchit = 1;
		loaded_matchparen = 1;
		loaded_logiPat = 1;
		loaded_rrhelper = 1;

		loaded_netrw = 1;
		loaded_netrwPlugin = 1;
		loaded_netrwSettings = 1;
    };
    vim.theme.enable = false;
    vim.options = {
        autowrite = false;
        confirm = true;
        cmdheight = 0;
        clipboard = "";
        expandtab = true;
        exrc = false;
        fileencoding = "utf-8";
        fillchars = {
            foldopen = "";
            foldclose = "";
            fold = " ";
            foldsep = " ";
            diff = "╱";
            eob = " ";
        };
        foldlevel = 99;
        # TODO: migrate to hybrid indent/marker
        foldmethod = "indent";
        formatoptions = "jcroqlnt"; # default tcqj
        #formatexpr = ""; #TODO:
        grepprg = "${lib.getExe pkgs.ripgrep} --vimgrep";
		grepformat = "%f:%l:%c:%m";
        hlsearch = false;
        history = 250;
        incsearch = true;
        number = true;
        relativenumber = true;
        scrolloff = 8;
        secure = true;
        shiftwidth = 4;
		sidescrolloff = 8;
		signcolumn = "yes";
		smartcase = true;
		smartindent = true;
		smoothscroll = true; ## vim >= 0.10
        #statuscolumn = "";
        tabstop = 4;
        textwidth = 0;
        title = true;
        termguicolors = true;
        wrap = false;
    };
    # disable plugin specific keymaps
    vim.vendoredKeymaps.enable = lib.mkForce false;
}
