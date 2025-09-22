# Instructions for Claude Code Agent

## Context
You are helping set up NixOS from a fresh install with Sway window manager. The user reverted to a snapshot right after initial install and wants to build the system step by step.

## Current Situation
- Fresh NixOS VM with "No Desktop" install
- No git initially installed, minimal packages only
- Configuration files will be in `~/nixos-config/` git repo after cloning
- Goal: Build a working Sway desktop environment INCREMENTALLY
- **CRITICAL**: Never break the working system - each step must build successfully

## Your Tasks - STEP BY STEP APPROACH

### Phase 1: Basic System Setup
1. Help user install git: `nix-env -iA nixos.git`
2. Clone configs: `git clone https://github.com/KristerV/nixos-config.git`
3. Install Claude Code with install script
4. Apply minimal.nix: `sudo cp minimal.nix /etc/nixos/configuration.nix && sudo nixos-rebuild switch`

### Phase 2: Add Sway Desktop
1. Copy sway-minimal.nix and add import to configuration.nix
2. Test rebuild - fix any issues before proceeding
3. Test Sway startup works

### Phase 3: Add Applications Gradually
1. Add packages in SMALL groups (3-5 at a time)
2. Test each group with `sudo nixos-rebuild switch`
3. If ANY package fails, comment it out and continue
4. Search for correct names: `nix search nixpkgs packagename`

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