{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    autokey
  ];

  nixpkgs.overlays = [
    (
      final: prev: {
        autokey = prev.autokey.overrideAttrs (upstream: {
          patches = (upstream.patches or [ ]) ++ [
            # https://github.com/autokey/autokey/issues/974#issuecomment-2487007454
            (builtins.toFile "python3next.patch" ''
              diff --git a/lib/autokey/gtkui/dialogs.py b/lib/autokey/gtkui/dialogs.py
              index 6f0dada..79b69f6 100644
              --- a/lib/autokey/gtkui/dialogs.py
              +++ b/lib/autokey/gtkui/dialogs.py
              @@ -333,7 +333,7 @@ class AbbrSettingsDialog(DialogBase):
                       # TODO: list comprehension or for loop, instead of manual loop
                       try:
                           while True:
              -                text = model.get_value(i.next().iter, 0)
              +                text = model.get_value(i.__next__().iter, 0)
                               ret.append(text)
                               # ret.append(text.decode("utf-8"))
                       except StopIteration:
            '')
          ];
        });
      }
    )
  ];
}
