# Instructions for Claude Code Agent

## Context
You are helping fix a NixOS configuration that was migrated from Arch Linux with Sway window manager. The user is running NixOS in a VM and the configuration has package name errors and compatibility issues.

## Current Situation
- NixOS VM is running with basic system
- Configuration files are in `/etc/nixos/` and also in `~/nixos-config/` git repo
- Main files: `configuration.nix`, `sway.nix`, `packages.nix`, `minimal.nix`
- `sudo nixos-rebuild switch` is failing with various package errors
- Goal: Get a working Sway desktop environment

## Your Tasks

### 1. First Priority: Fix Rebuild Errors
- Run `sudo nixos-rebuild switch` and capture errors
- Fix package name issues one by one:
  - Search for correct package names: `nix search nixpkgs packagename`
  - Check if packages exist in current NixOS version
  - Comment out packages that don't exist rather than failing entire build

### 2. Package Name Issues to Watch For
- Font packages: `noto-fonts-cjk` → `noto-fonts-cjk-sans`
- GNOME packages: `gnome.nautilus` → `nautilus`
- Teams: `teams` → `teams-for-linux`
- Database: `dbeaver` → `dbeaver-bin`
- Missing packages: comment out with `# packagename  # Not available in stable`

### 3. Strategy
- Use `allowBroken = true` in nixpkgs.config if needed
- Comment out entire sections if they're causing issues
- Start with minimal.nix if current configs are too broken
- Build incrementally - get basic system working first, then add packages

### 4. Testing Commands
```bash
# Test rebuild
sudo nixos-rebuild switch

# Search packages
nix search nixpkgs discord

# Test specific package
nix-build -E 'with import <nixpkgs> {}; discord'

# Dry run
sudo nixos-rebuild dry-build
```

### 5. Git Workflow
The configs are version controlled:
```bash
cd ~/nixos-config
git pull  # Get latest changes
# Edit files
git add -A && git commit -m "Fix package issues" && git push
sudo cp *.nix /etc/nixos/
sudo nixos-rebuild switch
```

### 6. End Goal
Working NixOS system with:
- Sway window manager
- Waybar status bar
- Common applications (Discord, Slack, Firefox, etc.)
- Development tools
- Estonian keyboard layout

## Quick Start
1. Check current errors: `sudo nixos-rebuild switch 2>&1 | head -20`
2. Fix the first error you see
3. Repeat until it builds successfully
4. Then gradually uncomment more packages

Good luck!