{pkgs, ...}: {
  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ./waybar;
    recursive = true;
  };

  xdg.configFile."dunst" = {
    source = ./dunst;
    recursive = true;
  };

  xdg.configFile."fuzzel" = {
    source = ./fuzzel;
    recursive = true;
  };

  home.packages = with pkgs; [
    niri
    nautilus
    xwayland-satellite
    fuzzel
    dunst
    swww
    xdg-desktop-portal
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
}
