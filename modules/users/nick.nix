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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  environment.localBinInPath = true;
}