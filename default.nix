{pkgs, ...}: {
    imports = [
        ./core
        ./plugins
    ];
    vim.extraPackages = [
        pkgs.fd
        pkgs.imagemagick
        pkgs.ripgrep
    ];
}
