{ config, pkgs, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    extraConfig.pipewire-pulse = {
      "99-disable-auto-gain-control" = {
        "pulse.rules" = [
          {
            actions = {
              quirks = [
                "block-source-volume"
              ];
            };
            matches = [
              {
                "application.process.binary" = "~.*";
              }
            ];
          }
        ];
      };
    };

    # audio.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    wireplumber = {
      enable = true;
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
        };
      };
    };
  };
}
