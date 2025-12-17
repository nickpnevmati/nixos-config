{ config, pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [
  #   openvpn
  #   networkmanager-vpnc
  #   networkmanager-openvpn
  # ];

  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
}
