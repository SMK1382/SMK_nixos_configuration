{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./modules/terminal.nix
    ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.mohammadreza = import ./modules/home.nix;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "SMK-HOST"; 
  networking.networkmanager.enable = true;

  programs.zsh = {
    enable = true;
  };

  users.defaultUserShell = pkgs.zsh; 

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  

  time.timeZone = "Asia/Tehran";

  services.xserver = {
  enable = true;
  xkb = {
  	layout = "us, ir";
	options = "grp:alt_shift_toggle";
  };
  windowManager = {
  	i3.enable = true;
  };
  };


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  

  services = {
  pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
  };
  };

   users.users.mohammadreza = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    brightnessctl
    git
    gh
    wget
    telegram-desktop
    mpv
    throne
    zip
    unzip
  ];


  services.openssh.enable = true;

  networking.firewall.enable = true;



  system.stateVersion = "25.11";
}
