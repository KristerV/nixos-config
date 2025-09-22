#!/bin/bash
# Script to copy your Arch configs to NixOS home directory
# Run this AFTER NixOS is installed in the VM

echo "This script will help migrate your configs to NixOS VM"
echo "Run this from your Arch host after NixOS is installed"
echo ""
echo "Usage: ./copy-configs.sh <nixos-vm-ip>"
echo ""

if [ -z "$1" ]; then
    echo "Please provide NixOS VM IP address"
    exit 1
fi

VM_IP=$1
VM_USER="krister"

echo "Copying Sway config..."
ssh $VM_USER@$VM_IP "mkdir -p ~/.config/sway"
scp ~/.config/sway/config $VM_USER@$VM_IP:~/.config/sway/
scp ~/.config/sway/workspaces $VM_USER@$VM_IP:~/.config/sway/
scp ~/.config/sway/outputs $VM_USER@$VM_IP:~/.config/sway/

echo "Copying Waybar config..."
ssh $VM_USER@$VM_IP "mkdir -p ~/.config/waybar"
scp ~/.config/waybar/config $VM_USER@$VM_IP:~/.config/waybar/
scp ~/.config/waybar/style.css $VM_USER@$VM_IP:~/.config/waybar/

echo "Copying terminal configs if they exist..."
[ -d ~/.config/foot ] && scp -r ~/.config/foot $VM_USER@$VM_IP:~/.config/
[ -d ~/.config/alacritty ] && scp -r ~/.config/alacritty $VM_USER@$VM_IP:~/.config/

echo "Copying git config..."
[ -f ~/.gitconfig ] && scp ~/.gitconfig $VM_USER@$VM_IP:~/

echo "Copying SSH keys (optional)..."
read -p "Copy SSH keys? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ssh $VM_USER@$VM_IP "mkdir -p ~/.ssh"
    scp ~/.ssh/id_* $VM_USER@$VM_IP:~/.ssh/
    scp ~/.ssh/config $VM_USER@$VM_IP:~/.ssh/ 2>/dev/null
fi

echo "Done! Remember to:"
echo "1. Adjust paths in configs if needed"
echo "2. Install any missing packages via nix-env or configuration.nix"
echo "3. Rebuild NixOS: sudo nixos-rebuild switch"