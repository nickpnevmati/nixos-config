{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    scala_3
    python3
  ];
}
