{ config, pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


	networking.hostName = "SMK_HOST";
	networking.networkmanager.enable = true
	networking.firewall.enable = true;

	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
	

	audio.enable = true;
	hardware.pulseaudio.enable = false;
	services.pipewire = {
            enable = true;
            pulse.enable = true;
            jack.enable = true;
        };


	program.zsh.enable = true;
	users.defaultUserShell = true;

	time.timeZone = "Asia/Tehran"


	programs.firefox.enable = true;


	services.xserver.enable = true;
	services.xserver.xkb.layout = "us, ir";
	services.xserver.options = "grp:alt_shift_toggle";
	services.windowManager.i3.enable = true;

	font.packages = with pkgs; [
		nerd-fonts.jetbrains.mono
	];
	

	programs.firefox.enable = true;

	
	enviroments.systemPackages = with pkgs; [
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
