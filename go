#!/usr/bin/env bash
set -eu
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

NIXOPTS="--option extra-binary-caches https://nixcache.reflex-frp.org/ -j 8"
nix-build shell.nix --drv-link "$DIR/gc-roots/shell.drv" $NIXOPTS --indirect --add-root "$DIR/gc-roots/shell.out" >/dev/null
nix-shell "$DIR/gc-roots/shell.drv" $NIXOPTS
