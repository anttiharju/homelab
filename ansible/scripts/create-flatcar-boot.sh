#!/usr/bin/env bash
set -euo pipefail

DISK=$1
PART_NUM=$(echo "$2" | grep -o '[0-9]*$')

# Create boot entry and capture the boot number in one step
BOOT_ENTRY=$(efibootmgr -c -d "$DISK" -p "$PART_NUM" -l '\EFI\BOOT\bootx64.efi' \
  -L 'Flatcar Linux' | grep "Flatcar Linux" | awk '{print $1}' | sed 's/Boot//' | sed 's/\*//')

# Set as next boot
efibootmgr -n "$BOOT_ENTRY"
echo "$BOOT_ENTRY"  # Return boot entry ID for checking changed status
