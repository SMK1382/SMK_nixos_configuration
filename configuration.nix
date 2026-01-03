{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./modules/system_config/system_config.nix
    ./modules/gui/terminal.nix
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.mohammadreza = import ./modules/home_manager/home.nix;
  users.users.mohammadreza = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "bluetooth"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  system.stateVersion = "25.11";
}
