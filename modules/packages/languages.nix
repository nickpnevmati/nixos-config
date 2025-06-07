{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_22
    python3
    clippy

    gcc
    clang
    rustup
    openssl.dev
    pkg-config
  ];
}
