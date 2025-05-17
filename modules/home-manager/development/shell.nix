{pkgs, ...}: {
  home.packages = with pkgs; [zoxide unzip];

  programs.bash.enable = true;
  programs.fish.enable = true;

  home.sessionPath = [
    "/home/thiago/.mix/escript"
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
