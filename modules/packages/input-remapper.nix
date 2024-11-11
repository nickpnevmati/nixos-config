{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    input-remapper
  ];

  services.input-remapper.enable = true;
  services.input-remapper.enableUdevRules = true; # optional, enables udev rules for hotplugged devices
}
