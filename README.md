# NixOS Configuration for Sway Desktop

Migrating from Arch Linux to NixOS with Sway window manager.

## Quick Start

### 1. Download NixOS ISO
```bash
# Get NixOS 24.11 (latest stable)
wget https://channels.nixos.org/nixos-24.11/latest-nixos-gnome-x86_64-linux.iso

# Or minimal ISO for faster download
wget https://channels.nixos.org/nixos-24.11/latest-nixos-minimal-x86_64-linux.iso
```

### 2. Create VM in Gnome Boxes
1. Open Gnome Boxes: `gnome-boxes`
2. Click "+" → "Operating System Download" → "Operating System ISO"
3. Select the downloaded ISO
4. Allocate at least:
   - 4GB RAM (8GB better)
   - 30GB disk space
5. Name it "NixOS Test"

### 3. Install NixOS in VM
1. Boot the ISO
2. Open terminal in live environment
3. Run installer: `sudo nixos-install`

Or manual install:
```bash
# Partition disk (assuming /dev/vda in VM)
sudo parted /dev/vda -- mklabel gpt
sudo parted /dev/vda -- mkpart ESP fat32 1MB 512MB
sudo parted /dev/vda -- set 1 esp on
sudo parted /dev/vda -- mkpart primary 512MB 100%

# Format
sudo mkfs.fat -F32 /dev/vda1
sudo mkfs.ext4 /dev/vda2

# Mount
sudo mount /dev/vda2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/vda1 /mnt/boot

# Generate config
sudo nixos-generate-config --root /mnt

# Copy our config
sudo cp /path/to/configuration.nix /mnt/etc/nixos/
sudo cp /path/to/sway.nix /mnt/etc/nixos/
sudo cp /path/to/packages.nix /mnt/etc/nixos/

# Install
sudo nixos-install

# Set root password when prompted
# Reboot
```

### 4. After First Boot
```bash
# Login as root
# Set user password
passwd krister

# Login as krister
# Copy configs from host (run copy-configs.sh from Arch host)

# Update system
sudo nixos-rebuild switch

# Start Sway
sway
```

## Configuration Files

- `configuration.nix` - Main system config
- `sway.nix` - Sway and Wayland setup
- `packages.nix` - User applications
- `hardware-configuration.nix` - Auto-generated hardware config

## Key Differences from Arch

| Arch | NixOS |
|------|-------|
| `pacman -S package` | Edit configuration.nix + `nixos-rebuild` |
| `yay -S aur-package` | Use nixpkgs or overlay |
| Config in ~/.config | Same, but system config in /etc/nixos |
| Rolling release | Stable + unstable channels |
| `/etc/fstab` | `hardware-configuration.nix` |

## Useful Commands

```bash
# Rebuild system
sudo nixos-rebuild switch

# Test changes without applying
sudo nixos-rebuild test

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Search packages
nix search nixpkgs firefox

# Temporary shell with package
nix-shell -p package-name

# List generations
sudo nix-env --list-generations

# Garbage collect old generations
sudo nix-collect-garbage -d

# Update channel
sudo nix-channel --update
```

## Notes

- Albert might need XWayland, consider wofi/rofi as native alternatives
- Caja replaced with Nautilus (better Wayland support)
- Some AUR packages might not exist, check alternatives
- PostgreSQL starts automatically as a service
- Docker daemon runs on boot

## VM Network Access

To SSH from host to VM:
1. Check VM IP: `ip addr` in VM
2. Or use Boxes port forwarding
3. SSH: `ssh krister@vm-ip`