#!/usr/bin/env bash
set -euo pipefail

lsblk -no NAME,PARTLABEL "$1"* | grep -i EFI | head -1 | awk '{print $1}'
