{ config, pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


	#networking.hostName = "SMK_HOST";
	networking.networkmanager.enable = true;
	networking.firewall.enable = true;

	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	

	hardware.pulseaudio.enable = false;
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
		pavucontrol
    		pipewire
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
