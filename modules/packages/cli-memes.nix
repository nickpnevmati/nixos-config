{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    figlet
    cowsay
    sl
  ];
}
