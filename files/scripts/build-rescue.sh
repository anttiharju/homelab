#!/usr/bin/env bash
set -euo pipefail

# Download upstream Debian Live ISO
url="https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-13.1.0-amd64-standard.iso"
iso_download_dir="$(git rev-parse --show-toplevel)/iso"
mkdir -p "$iso_download_dir"
if [ ! -f "$iso_download_dir/debian-live-13.1.0-amd64-standard.iso" ]; then
    echo "Downloading Debian Live ISO..."
    curl -L -o "$iso_download_dir/debian-live-13.1.0-amd64-standard.iso" "$url"
else
    echo "Debian Live ISO already exists, skipping download."
fi
