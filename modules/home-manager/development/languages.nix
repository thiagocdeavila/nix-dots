{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd
    alejandra

    elixir
    lexical
    elixir-ls

    erlang

    gcc
    glib
    gnumake
  ];
}
