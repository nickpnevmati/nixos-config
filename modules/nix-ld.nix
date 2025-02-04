{ config, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    corretto11
    stdenv.cc.cc.lib
    zlib # numpy
  ];
}
