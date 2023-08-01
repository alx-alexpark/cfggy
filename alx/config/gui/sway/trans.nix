{ pkgs, ... }:
pkgs.writers.writePython3Bin "trans.py" { libraries = with pkgs.python39Packages; [ six i3ipc ]; } (builtins.readFile ./trans.py)
