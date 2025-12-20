{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_22
    python3
    clippy

    gcc
    clang
    openssl.dev
    pkg-config
    dotnet-sdk_9
  ];
}
