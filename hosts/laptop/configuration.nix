# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nuclear-laptop";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      # Allow KDE Connect
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      # Allow KDE Connect
      { from = 1714; to = 1764; }
    ];
  };

  time.timeZone = "Europe/Athens";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.nick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "bluetooth" "docker" ];
  };

  users.extraGroups.vboxusers.members = [ "nick" ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    spectacle
    discover
    elisa
    khelpcenter
    gwenview
  ];

  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
    guest.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Web Browsers
    firefox
    opera
    google-chrome
    tor-browser

    # Comms
    discord
    slack
    zoom-us

    #Media
    vlc
    spotify
    stremio
    digikam

    # Utils
    flameshot
    autokey
    input-remapper
    # qbittorrent

    # Office
    libreoffice-qt6-fresh

    # CLI Stuff
    tree
    wget
    unzip

    # Development
    python3
    vscode
    docker
    docker-compose
    kubernetes
    insomnia
    # bruno
    git
    gh
    
    # Bluetooth
    bluez
    bluedevil

    # Nixos Specifics
    nil
    nixpkgs-fmt

    # KDE Packages
    kdePackages.okular
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.yakuake
    kdePackages.kdeconnect-kde
    kdePackages.konsole
  ];

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
    };
  };

  services.dbus.enable = true;

  services.flatpak.enable = true;

  # services.bluetooth.enable = true;
  hardware.bluetooth.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us, gr";
  services.xserver.xkb.options = "eurosign:e";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.defaultSession = "plasmax11";
  services.desktopManager.plasma6.enable = true;

  # Enable Input Remapper
  services.input-remapper.enable = true;
  services.input-remapper.enableUdevRules = true; # optional, enables udev rules for hotplugged devices

  # DO NOT CHANGE THIS UNDER ANY CIRCUMSTANCE
  system.stateVersion = "24.05";
}

