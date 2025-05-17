{pkgs, ...}: {
  xdg.configFile."ghostty" = {
    source = ./ghostty;
    recursive = true;
  };

  home.packages = with pkgs; [
    ghostty
  ];
}
