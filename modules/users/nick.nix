{ config, lib, pkgs, ... }:

{
  users.users.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "bluetooth" "docker" ];
  };

  environment.localBinInPath = true;
}