# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./modules/shell.nix
      ./modules/terminal.nix
      #./modules/windows-manager.nix
    ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.mohammadreza = import ./modules/home.nix;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "SMK-HOST"; # Define your hostname.
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;


  # در configuration.nix

  # systemd.packages = with pkgs; [ bluez ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  #systemd.services.bluetooth = {
  #  enable = true;
  #  wantedBy = [ "multi-user.target" ];
  # };


  # Set your time zone.
  time.timeZone = "Asia/Tehran";
  # services.automatic-timezoned.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  

  # Enable the X11 windowing system.
   services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
   };




  services.xserver.xkb.layout = "us,ir";
  services.xserver.xkb.options = "grp:alt_shift_toggle";
  
  # fonts.packages = with pkgs; [
  #  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    #(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    # nerd-fonts.jetbrains-mono
  #];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # services.pipewire.enable = false;
  # services.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  # };
  # OR
  #services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  #};
  services = {
  pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
  };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mohammadreza = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ]; # Enable ‘sudo’ for the user.
     # password = "mypassword";
     packages = with pkgs; [
       tree
     ];
   };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    alacritty
    #cascadia-code  
    telegram-desktop
    git
    gh
    mpv
    neko
    v2ray
    v2rayn
    xray
    appimage-run
    throne
    zip
    unzip
    brightnessctl
  ];

  #programs.zsh.enable = true;

  #users.defaultUserShell = pkgs.zsh;
    #programs.zsh.promptInit = ''
    # غیرفعال کردن Powerlevel10k
    # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

  #PROMPT="%1~ %F{4}❯%f "
  #RPROMPT=""
  #PROMPT2="%B%F{4}❯%f%b "
  #RPS1=""

  # تغییر رنگ فلش به قرمز وقتی دستور قبلی خطا داشت
  #precmd() {
  #  if [[ $? -eq 0 ]]; then
  #    PROMPT='%1~ %F{4}❯%f '
  #  else
  #    PROMPT='%1~ %F{1}❯%f '
  #  fi
  #}

  # tab completion واضح (تنظیمات قبلی شما را نگه داشتم)
  #zstyle ':completion:*' list-colors 'fi=37:di=37:ln=36:ex=32'
  #zstyle ':completion:*' menu select
  #'';
  #services.v2raya.enable = true;
  # Optional: Enable transparent proxy if needed (requires additional setup like nftables/iptables capabilities)
  # services.v2raya.transparentProxy = true;
  # To make it accessible in your browser easily



  services.resolved.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true; 
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #home.packages = with pkgs; [
  #    alacritty
  #    jetbrains-mono
  #    nerd-fonts
  #  ];
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 10808 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  boot.kernelModules = [ "tun" ];
  programs.throne.tunMode.enable = true;
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
