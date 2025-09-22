# NixOS Fresh Install - Step by Step Setup

## Starting Point
Fresh NixOS install with "No Desktop" - just console login, no git, minimal packages.

## Step 1: Install Git and Get Configs
```bash
# Install git temporarily
nix-env -iA nixos.git

# Clone configs
git clone https://github.com/KristerV/nixos-config.git

# Install Claude Code
cd nixos-config
chmod +x install-claude.sh
./install-claude.sh
```

## Step 2: Start with Minimal Working System
```bash
# Copy minimal config first
sudo cp minimal.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```

## Step 3: Add Components Incrementally

### Phase 1: Basic System (minimal.nix is already this)
- SSH, git, basic tools
- User account with sudo
- Estonian keyboard

### Phase 2: Add Display Server
```bash
# Test basic sway components
sudo cp sway-minimal.nix /etc/nixos/sway.nix
# Add import to configuration.nix
sudo nixos-rebuild switch
```

### Phase 3: Add Applications One by One
```bash
# Add packages in small groups
# Test each group with nixos-rebuild
```

### Phase 4: Copy User Configs
```bash
# After system is stable, copy dotfiles
```

## Philosophy
- **Never break the system** - each step should build successfully
- **Test immediately** - rebuild after each change
- **Comment out problems** - don't let one package break everything
- **Build incrementally** - basic system → display → apps → configs

## For Claude Code Agent
When you start, read CLAUDE-INSTRUCTIONS.md but focus on:
1. Getting minimal.nix working first
2. Adding ONE component at a time
3. Testing each addition
4. Only moving to next step when current step works

The user can revert to snapshot if something breaks badly.