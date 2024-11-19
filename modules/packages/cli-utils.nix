{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tree
    wget
    unzip
    rar
    ffmpeg
    git
    gh
    woeusb
    xdotool
    pciutils
    dnsutils
    fzf
  ];
}