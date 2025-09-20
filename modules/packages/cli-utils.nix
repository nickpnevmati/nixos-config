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
    xbindkeys
    sxhkd
    xorg.xev
    pciutils
    dnsutils
    fzf
    bat
    zip
    poppler_utils
    imagemagick
    android-tools
    nmap
    zoxide
    lsd
    stow
    oh-my-posh
    twilio-cli
    qmk
    pdftk
    nixos-generators
  ];
}