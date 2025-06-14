#!/usr/bin/env bash
set -euo pipefail

# Create a working directory
mkdir -p ./alpine-custom && cd ./alpine-custom
echo "*" > .gitignore

# Download the latest Alpine Linux extended ISO only if it doesn't exist
alpine_version="3.22"
alpine_version_patch="0"
alpine_iso_file="alpine-extended-$alpine_version.$alpine_version_patch-x86_64.iso"
if [ ! -f "$alpine_iso_file" ]; then
  echo "Downloading Alpine Linux extended ISO..."
  wget https://dl-cdn.alpinelinux.org/alpine/v$alpine_version/releases/x86_64/$alpine_iso_file
else
  echo "Alpine ISO already exists, skipping download."
fi
