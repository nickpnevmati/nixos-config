{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  boot.kernelParams = [
    "video=DP-1:2560x1440@144"
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    clinfo
    radeontop
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];
}
