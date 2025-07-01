{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    google-chrome
    azuredatastudio
    mysql-workbench
  ];
}
