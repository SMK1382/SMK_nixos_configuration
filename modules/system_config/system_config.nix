{ config, pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


	time.timeZone = "Asia/Tehran";


	programs.firefox.enable = true;


	services.xserver.enable = true;
	services.xserver.xkb.layout = "us, ir";
	services.xserver.xkb.options = "grp:alt_shift_toggle";
	services.xserver.windowManager.i3.enable = true;


	services.libinput.enable = true;
	services.libinput.touchpad.disableWhileTyping = true;


	networking.hostName = "SMK-HOST";
	networking.networkmanager.enable = true;
	networking.firewall.enable = true;

	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	

	services.pulseaudio.enable = false;
	services.pipewire = {
            enable = true;
            pulse.enable = true;
            jack.enable = true;
        };


	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];
	
	boot.kernelModules = [ "tun" ];
	programs.throne = {
   		enable = true;
    		tunMode = {
      		enable = true;
      		setuid = false;
    	        };
  	};

	environment.systemPackages = with pkgs; [
 		neovim
		pamixer
		pavucontrol
    		wireplumber
		git
		gh
		telegram-desktop
		mpv
		zip
		unzip
		unrar-free
		wget
		tree
		throne
		python3
		nodejs_24
		brightnessctl
		v2rayn
		btop
	];

}
