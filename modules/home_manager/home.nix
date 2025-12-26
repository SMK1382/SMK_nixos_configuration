{ config, pkgs, ... } :
{
	imports = [
		../gui/shell.nix
		../gui/windows_manager.nix
	];
	home.username = "mohammadreza";
	home.homeDirectory = "/home/mohammadreza";
	home.stateVersion = "25.11";
}
