#!/usr/bin/env bash

cd /tmp
version=1.10.3
url="https://github.com/siderolabs/talos/releases/download/v$version/metal-amd64.iso"
curl -LsSf -o talos-amd64.iso "$url"
sudo dd if=talos-amd64.iso of=/dev/nvme0n1 bs=4M status=progress
sudo reboot now
