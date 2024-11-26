{ config, lib, pkgs, ... }:

{
  users.users.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "bluetooth" "docker" ];

    packages = with pkgs; [
      zsh
    ];

    shell = pkgs.zsh;
  };

  environment.localBinInPath = true;
}