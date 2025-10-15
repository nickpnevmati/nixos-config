{ config, lib, pkgs, inputs, ... }:

{
    boot = {
        consoleLogLevel = 0;
        kernelParams = [ "quiet" "splash" ];
        loader = {
            systemd-boot.enable = true;
            loader = {
                efi.canTouchEfiVariables = true;
                timeout = 0;
            };
        };
    };

    systemd.showStatus = false;
}

