{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    opera
    google-chrome
  ];
}
