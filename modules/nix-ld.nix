{ config, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    corretto11
    stdenv.cc.cc.lib

    # PYTHON DEVELOPMENT IS ABSOLUTE BULLSHIT IN THIS OS
    zlib
    libGL
    libGLU
    xorg.libX11
    # PYTHON DEVELOPMENT IS ABSOLUTE BULLSHIT IN THIS OS
  ];
}
