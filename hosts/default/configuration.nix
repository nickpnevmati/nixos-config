# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/packages/amdgpu.nix
    ../../modules/packages/kde.nix
    ../../modules/packages/work.nix
    ../../modules/packages/docker.nix
    ../../modules/packages/virtualbox.nix
    ../../modules/packages/input-remapper.nix
    ../../modules/packages/editors.nix
    ../../modules/packages/languages.nix
    ../../modules/packages/cli-utils.nix
    ../../modules/packages/cli-memes.nix
    ../../modules/packages/zsh.nix

    ../../modules/nix-ld.nix

    ../../modules/users/nick.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.hardwareClockInLocalTime = true;

  networking.hostName = "nuclear-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Athens";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Web Browsers
    firefox
    tor-browser

    # Comms
    discord
    zoom-us

    #Media
    vlc
    spotify
    stremio
    digikam
    gimp

    # Utils
    flameshot
    autokey
    deluge

    # Office
    libreoffice-qt6-fresh

    # Development
    insomnia

    # Bluetooth
    bluez

    # Nixos Specifics
    nil
    nixpkgs-fmt
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
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
  
  # services.bluetooth.enable = true;
  hardware.bluetooth.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.displayManager.defaultSession = "plasmax11";
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us, gr";
  services.xserver.xkb.options = "eurosign:e";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
  };

  # DO NOT CHANGE THIS UNDER ANY CIRCUMSTANCE
  system.stateVersion = "24.05";
}

