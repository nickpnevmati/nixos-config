{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntax-highlighting.enable = true;
  };
}