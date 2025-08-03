{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    dropbox # para salvar as notas do obsidian
    anki-bin
  ];
}
