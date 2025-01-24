{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    jetbrains.rust-rover
    jetbrains.pycharm-community
    jetbrains.idea-community
    jetbrains.rider
  ];
}
