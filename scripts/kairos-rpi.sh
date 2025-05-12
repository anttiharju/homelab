#!/usr/bin/env bash
set -euo pipefail

# Kairos appears to not work on the Raspberry Pi 3B+, but writing this script took a lot of effort, so I'm saving it.
# Targeting Raspberry Pi 4 might yield better results, but I don't have one to test with.

os=opensuse
version="leap-15.6-core-arm64-rpi3-v3.2.4"

img="kairos-$os-$version.img"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
(
    cd "$tmp"
    # github.com/anttiharju/utils/scripts/docker-rip.sh
    docker-rip "quay.io/kairos/$os:$version-img" build
    printf "Extracting roughly 14500 MiB (14.5 GiB) .img file from "
    xz -dv "$img.xz"
    # should work the same on both macOS and Linux
    sed 's|/build/|./|' "$img.sha256" > "$img.sha256.tmp" && mv "$img.sha256.tmp" "$img.sha256"
)

mkdir -p img
(
    cd img
    echo '*' > .gitignore
    mv "$tmp/$img" "$img"
    mv "$tmp/$img.sha256" "$img.sha256"
    echo "Verifying sha256sum"
    sha256sum -c "$img.sha256"
)
