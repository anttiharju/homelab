#!/usr/bin/env bash
set -euo pipefail

lsblk -lno NAME,PARTLABEL "$1"* | grep -i EFI | head -1 | awk '{print $1}'
