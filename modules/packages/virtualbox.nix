{ config, lib, pkgs, ... }:

{
  users.extraGroups.vboxusers.members = [ "nick" ];

  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
    guest.enable = true;
  };
}