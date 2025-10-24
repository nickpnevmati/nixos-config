# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

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
    ../../modules/packages/vpn.nix

    ../../modules/fonts.nix
    ../../modules/nix-ld.nix
    ../../modules/audio.nix
    ../../modules/boot.nix

    ../../modules/users/nick.nix
  ];

  time.hardwareClockInLocalTime = true;

  networking.hostName = "nuclear-desktop";
  networking.networkmanager.enable = true;
  boot.loader.timeout = 0;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 ];
    allowedUDPPorts = [ 8000 ];
  };

  time.timeZone = "Europe/Athens";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Web Browsers
    inputs.zen-browser.packages."${system}".default
    firefox
    tor-browser

    (callPackage ../../modules/packages/webots.nix {})

    # Comms
    discord
    zoom-us

    unityhub

    #Media
    vlc
    spotify
    stremio
    digikam
    blender
    gimp
    obs-studio


    # Utils
    flameshot
    autokey
    deluge

    # Office
    libreoffice-qt6-fresh

    # Development
    insomnia
    dotnetCorePackages.dotnet_9.sdk

    # Nixos Specifics
    nil
    nixpkgs-fmt
  ];

  services.dbus.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    opentabletdriver.enable = true;
  };

  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "us, gr";
        options = "eurosign:e";
      };
    };

    displayManager = {
      defaultSession = "plasmax11";

      autoLogin.user = "nick";

      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };

    openssh.enable = true;

    libinput.enable = true;

    desktopManager.plasma6.enable = true;
  };

  # DO NOT CHANGE THIS UNDER ANY CIRCUMSTANCE
  system.stateVersion = "24.05";
}

