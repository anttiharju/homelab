#!/usr/bin/env bash
set -euo pipefail

# Check for required tools
if ! command -v 7z &> /dev/null; then
    echo "7z is required but not installed. Please install it with 'brew install p7zip'."
    exit 1
fi

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

# Create temp directories for extraction
echo "Preparing Debian Live for PXE boot..."
extract_dir="/tmp/debian-iso-extract"
tftp_dir="$(git rev-parse --show-toplevel)/roles/router/files/tftp"
debian_tftp_dir="${tftp_dir}/debian-live"

# Clean up previous files if they exist
rm -rf "${extract_dir}" "${debian_tftp_dir}"
mkdir -p "${extract_dir}" "${debian_tftp_dir}/live"

# Extract ISO with 7z instead of mounting
echo "Extracting ISO contents with 7z (this may take a while)..."
iso_file="${iso_download_dir}/debian-live-13.1.0-amd64-standard.iso"
7z x -o"${extract_dir}" "${iso_file}"

# Check if extraction was successful
if [ ! -d "${extract_dir}/boot" ] || [ ! -d "${extract_dir}/live" ]; then
    echo "Error: Expected directory structure not found in extracted ISO."
    echo "Contents of extract directory:"
    ls -la "${extract_dir}"

    echo "Trying to find important files in the extracted ISO:"
    find "${extract_dir}" -name "vmlinuz" -o -name "initrd.img" -o -name "grub.efi" -o -name "filesystem.squashfs"
    exit 1
fi

# Copy bootloader files
echo "Copying bootloader files..."
cp -r "${extract_dir}/boot/grub" "${debian_tftp_dir}/"

# Copy kernel and initrd
echo "Copying kernel and initrd..."
cp "${extract_dir}/live/vmlinuz" "${debian_tftp_dir}/"
cp "${extract_dir}/live/initrd.img" "${debian_tftp_dir}/"

# Copy filesystem.squashfs
echo "Copying filesystem.squashfs (this may take a while)..."
cp "${extract_dir}/live/filesystem.squashfs" "${debian_tftp_dir}/live/"

# Create GRUB configuration
echo "Creating GRUB configuration..."
cat > "${debian_tftp_dir}/grub/grub.cfg" << EOF
set timeout=5
set default=0

menuentry "Debian Live Standard" {
    linux /debian-live/vmlinuz boot=live components fetch=tftp://192.168.8.1/debian-live/live/filesystem.squashfs
    initrd /debian-live/initrd.img
}
EOF

# Find and copy GRUB EFI bootloader
echo "Looking for GRUB EFI bootloader..."
efi_file=$(find "${extract_dir}" -name "bootx64.efi" -o -name "grubx64.efi" -o -name "grub.efi" | grep -i efi | head -n 1)

if [ -z "${efi_file}" ]; then
    # Extract EFI bootloader from GRUB efi.img if available
    if [ -f "${debian_tftp_dir}/grub/efi.img" ]; then
        echo "Extracting EFI bootloader from efi.img..."
        temp_efi_dir="/tmp/efi-extract"
        mkdir -p "${temp_efi_dir}"

        # Try to extract with 7z
        7z x -o"${temp_efi_dir}" "${debian_tftp_dir}/grub/efi.img" || true

        # Look for EFI file in extracted contents
        efi_file=$(find "${temp_efi_dir}" -name "*.efi" | head -n 1)

        if [ -n "${efi_file}" ]; then
            echo "Found EFI bootloader: ${efi_file}"
        else
            echo "No EFI bootloader found in efi.img."

            # As a fallback, create a basic GRUB EFI config and generate one
            echo "Creating fallback GRUB EFI bootloader from netboot.xyz..."
            cp "$(git rev-parse --show-toplevel)/roles/router/files/tftp/netboot.xyz.efi" "${tftp_dir}/debian-live.efi"

            # Create a netboot.xyz menu entry
            echo "Creating netboot.xyz menu entry for Debian Live..."
            echo "Warning: Using netboot.xyz as fallback. This might not work correctly."
            rm -f "${debian_tftp_dir}/grub/grub.cfg"
            cat > "${debian_tftp_dir}/grub/grub.cfg" << EOF
set timeout=5
set default=0

menuentry "Debian Live Standard (TFTP)" {
    set root=(tftp)
    linux /debian-live/vmlinuz boot=live components fetch=tftp://192.168.8.1/debian-live/live/filesystem.squashfs
    initrd /debian-live/initrd.img
}
EOF
        fi

        # Clean up temp directory
        rm -rf "${temp_efi_dir}"
    else
        echo "Error: No EFI bootloader found and no efi.img available."
        echo "Looking for any EFI files in the ISO:"
        find "${extract_dir}" -name "*.efi"
        exit 1
    fi
else
    echo "Found EFI bootloader: ${efi_file}"
    mkdir -p "${tftp_dir}"
    cp "${efi_file}" "${tftp_dir}/debian-live.efi"
    echo "Copied EFI bootloader to ${tftp_dir}/debian-live.efi"
fi

# Clean up
echo "Cleaning up..."
rm -rf "${extract_dir}"

echo "PXE boot files prepared successfully!"
echo ""
echo "To use these files:"
echo "1. Copy the contents of ${tftp_dir} to your TFTP server's root directory"
echo "2. Update dnsmasq.conf to use 'dhcp-boot=debian-live.efi,192.168.8.1'"
echo ""
echo "Note: Ensure your TFTP server is configured to handle large file transfers,"
echo "      as filesystem.squashfs is several hundred MB in size."
