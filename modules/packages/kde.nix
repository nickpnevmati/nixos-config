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
    kwallet-pam
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    spectacle
    discover
    elisa
    khelpcenter
    gwenview
  ];

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
