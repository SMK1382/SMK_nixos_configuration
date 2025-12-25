{ config, pkgs, ... } :
{
	imports = [
		./shell.nix
		./windows-manager.nix
	];
	home.username = "mohammadreza";
	home.homeDirectory = "/home/mohammadreza";
	home.stateVersion = "25.11";
}
