{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    google-chrome
    cloudflare-warp
  ];

  services.cloudflare-warp.enable = true;
}
