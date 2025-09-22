# Quick NixOS Setup with Graphical Installer

## 1. Use Graphical Installer
- Boot the graphical ISO
- Use the installer (yes to encryption if you want!)
- Create user "krister"
- Let it install with GNOME
- Reboot

## 2. After First Boot - Quick Config Switch

```bash
# Login as krister, open terminal

# Quick way - download configs directly
cd /tmp
curl -LO https://raw.githubusercontent.com/[if-you-push-to-github]/configuration.nix
# OR start a quick server on your Arch host:
# python3 -m http.server 8000 --directory ~/code/nixos
# Then in VM: curl -O http://192.168.122.1:8000/{configuration,sway,packages}.nix

# Backup original and copy ours
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp *.nix /etc/nixos/

# Switch to Sway setup
sudo nixos-rebuild switch

# Logout, login, type: sway
```

## 3. For Live Editing - Set Up Shared Folder

**On your Arch host:**
```bash
# Install if needed
sudo pacman -S qemu-virtiofs

# Share via SSHFS (easier than 9p)
# In VM after install:
sudo mkdir /shared
sudo sshfs krister@192.168.122.1:/home/krister/code/nixos /shared -o allow_other

# Now /shared points to your host configs!
```

**Or use Gnome Boxes built-in sharing:**
- Boxes → VM Properties → Devices & Shares → Toggle ON
- It auto-mounts in `/media/` in modern VMs

Then symlink configs:
```bash
sudo ln -sf /shared/configuration.nix /etc/nixos/
sudo ln -sf /shared/sway.nix /etc/nixos/
sudo ln -sf /shared/packages.nix /etc/nixos/
```

Now just edit on host and `sudo nixos-rebuild switch` in VM!