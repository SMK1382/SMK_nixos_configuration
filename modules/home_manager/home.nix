{ config, pkgs, ... } :
{
	imports = [
		../gui/shell.nix
		../gui/windows_manager.nix
#		../neovim/neovim.nix
	];
	home.username = "mohammadreza";
	home.homeDirectory = "/home/mohammadreza";
	home.stateVersion = "25.11";
}
