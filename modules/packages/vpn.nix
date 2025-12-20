{ config, pkgs, ... }:

{
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
}
