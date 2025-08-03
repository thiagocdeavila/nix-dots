{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim

    tree-sitter
    nodejs

    # Utils
    wl-clipboard
    fzf
    ripgrep
    fd

    # LSPs
    lua-language-server
    ruby-lsp
    tailwindcss-language-server
    typescript-language-server
    vue-language-server
    elixir-ls
  ];

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
