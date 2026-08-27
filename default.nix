{pkgs, ...}: {
    imports = [
        ./core
        ./langs
        ./plugins
    ];
    vim.extraPackages = [
        pkgs.fd
        pkgs.imagemagick
        pkgs.ripgrep
    ];
}
