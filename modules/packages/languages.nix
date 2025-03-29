{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_22
    python3

    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
  ];
}
