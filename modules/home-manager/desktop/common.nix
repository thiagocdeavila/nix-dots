{pkgs, ...}: {
  home.packages = with pkgs; [libreoffice vlc mpv];
}
