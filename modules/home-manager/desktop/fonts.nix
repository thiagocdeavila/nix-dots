{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.monaspace
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = ["Noto Fonts"];
    };
  };
}
