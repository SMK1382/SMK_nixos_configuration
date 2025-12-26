{ config, pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


<<<<<<< HEAD
	#networking.hostName = "SMK_HOST";
=======
	networking.hostName = "SMK-HOST";
>>>>>>> a5796cb (4)
	networking.networkmanager.enable = true;
	networking.firewall.enable = true;

	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	
<<<<<<< HEAD

	hardware.pulseaudio.enable = false;
=======
	services.pulseaudio.enable = false;
>>>>>>> a5796cb (4)
	services.pipewire = {
            enable = true;
            pulse.enable = true;
            jack.enable = true;
        };


	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	time.timeZone = "Asia/Tehran";


	programs.firefox.enable = true;


	services.xserver.enable = true;
	services.xserver.xkb.layout = "us, ir";
	services.xserver.xkb.options = "grp:alt_shift_toggle";
	services.xserver.windowManager.i3.enable = true;

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];
	
	
	environment.systemPackages = with pkgs; [
 		neovim
<<<<<<< HEAD
		pavucontrol
=======
>>>>>>> a5796cb (4)
    		pipewire
		pamixer
		pavucontrol
    		wireplumber
		git
		gh
		telegram-desktop
		mpv
		zip
		unzip
		wget
		tree
	];

}
