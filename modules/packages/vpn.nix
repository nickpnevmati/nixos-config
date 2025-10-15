{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openvpn
    networkmanager-vpnc
    networkmanager-openvpn
  ];
}
