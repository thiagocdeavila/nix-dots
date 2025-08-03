{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    discord-canary
    thunderbird
  ];
}
