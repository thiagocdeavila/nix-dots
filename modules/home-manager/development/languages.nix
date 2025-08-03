{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd
    alejandra

    elixir
    erlang

    gcc
    glib
    gnumake
  ];
}
