{pkgs, ...}: {
  home.file.".emacs.d" = {
    source = ./config;
    recursive = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        treesit-grammars.with-all-grammars
        astro-ts-mode
        nix-ts-mode
        vterm
        treesit-auto
      ];
  };
}
