{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    okular
    ark
    dolphin
    yakuake
    kdeconnect-kde
    konsole
    kdenlive
    kcmutils
    bluedevil
    bluez-qt
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    spectacle
    discover
    elisa
    khelpcenter
  ];
  
  security.pam.services.nick.kwallet ={
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  # Allowed ports for KDEconnect
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}
