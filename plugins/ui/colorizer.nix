{
    vim.ui.colorizer.enable = true;
    vim.ui.colorizer.setupOpts = {
        user_default_options = { names = false; };
    };
    vim.utility.images.image-nvim.enable = true;
    vim.utility.images.image-nvim.setupOpts = {
        backend = "kitty";
        integrations = {
            markdown = {
                enabled = true;
                clear_in_insert_mode = false;
                download_remote_images = true;
                only_render_image_at_cursor = false;
                only_render_image_at_cursor_mode = "popup"; ## or "inline"
                floating_windows = false; ## if true, images will be rendered in floating markdown windows
                filetypes = [ "markdown" "vimwiki" ]; ## markdown extensions (ie. quarto) can go here
            };
            asciidoc = {
                enabled = true;
                clear_in_insert_mode = false;
                download_remote_images = true;
                only_render_image_at_cursor = false;
                only_render_image_at_cursor_mode = "popup";
                floating_windows = false;
                filetypes = [ "asciidoc" "adoc" ];
            };
            neorg = {
                enabled = true;
                filetypes = [ "norg" ];
            };
        };
    };

    # setupOpts = {
    #     events = {
    #         render_buffer = [ "InsertLeave" "BufWinEnter" "TextChanged" ];
    #             clear_buffer = [ "BufLeave" ];
    #         };
    #         renderer_options = {
    #             mermaid = {
    #                 background = "dark"; ## nil | "transparent" | "white" | "#hex"
    #                 theme = "nil"; ## nil | "default" | "dark" | "forest" | "neutral"
    #                 scale = 2; ## nil | 1 (default) | 2  | 3 | ...
    #                 width = "nil"; ## nil | 800 | 400 | ...
    #                 height = "nil"; ## nil | 600 | 300 | ...
    #                 cli_args = null; ## nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
    #             };
    #             plantuml = {
    #                 charset = "nil";
    #                 cli_args = "nil"; ## nil | { "-Djava.awt.headless=true" } | ...
    #             };
    #             d2 = {
    #                 theme_id = "nil";
    #                 dark_theme_id = "nil";
    #                 scale = "nil";
    #                 layout = "nil";
    #                 sketch = "nil";
    #                 cli_args = "nil"; ## nil | { "--pad", "0" } | ...
    #             };
    #             gnuplot = {
    #                 size = "nil"; ## nil | "800,600" | ...
    #                 font = "nil"; ## nil | "Arial,12" | ...
    #                 theme = "nil"; ## nil | "light" | "dark" | custom theme string
    #                 cli_args = "nil"; ## nil | { "-p" } | { "-c", "config.plt" } | ...
    #             };
    #         };
    #     };

}
