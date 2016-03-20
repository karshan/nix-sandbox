#!/usr/bin/env bash
NIXOPTS="--option extra-binary-caches https://nixcache.reflex-frp.org/ -j 8"
nix-build shell.nix --drv-link /home/karshan/nix-sandbox/gc-roots/shell.drv $NIXOPTS --indirect --add-root /home/karshan/nix-sandbox/gc-roots/shell.out >/dev/null
nix-shell /home/karshan/nix-sandbox/gc-roots/shell.drv $NIXOPTS
