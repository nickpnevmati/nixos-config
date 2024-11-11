{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    input-remapper
  ];

  services.displayManager.defaultSession = "plasmax11";
  services.desktopManager.plasma6.enable = true;
}
