{ config, lib, pkgs, inputs, ... }:

{
    boot = {
        consoleLogLevel = 0;
        initrd.verbose = false;
        kernelParams = [ 
            "quiet" 
            "splash"
            "loglevel=3"
            "rd.systemd.show_status=false"
            "rd.udev.log_priority=3"
            "udev.log_priority=3"
            "systemd.show_status=false"
            "vt.global_cursor_default=0"
            "consoleblank=0"
        ];
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };
        plymouth = {
            enable = true;
            theme = "bgrt";
        };
    };

}

