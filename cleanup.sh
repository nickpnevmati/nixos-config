sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 5d
sudo nix-collect-garbage
sudo /run/current-system/bin/switch-to-configuration boot