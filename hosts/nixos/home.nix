{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/desktop
    ../../modules/home-manager/development
  ];

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
  };

  home.packages = with pkgs; [transmission_4-gtk];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
