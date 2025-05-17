{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/nixos/system
    ../../modules/nixos/development
    ./hardware-configuration.nix
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = with pkgs; [niri];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "gnome";
    configPackages = with pkgs; [niri];
    extraPortals = with pkgs; [xdg-desktop-portal-gnome];
  };

  console.keyMap = "us";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  users.users.thiago = {
    isNormalUser = true;
    description = "Thiago";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    gparted
  ];

  security.polkit.enable = true;
  programs.ssh.startAgent = true;

  systemd.user.services.niri-polkit = {
    description = "PolicyKit Authentication Agent";
    wantedBy = ["niri.service"];
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  system.stateVersion = "25.05";
}
