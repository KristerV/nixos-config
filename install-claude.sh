#!/bin/bash
# Install Claude Code on NixOS

echo "Installing Claude Code..."

# Download latest release
curl -L https://github.com/anthropics/claude-code/releases/latest/download/claude-code-linux-x86_64.tar.gz -o /tmp/claude-code.tar.gz

# Extract
cd /tmp
tar xzf claude-code.tar.gz

# Install to system
sudo mv claude-code /usr/local/bin/
sudo chmod +x /usr/local/bin/claude-code

# Add to PATH if needed
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc

echo "Claude Code installed! Run: claude-code"
echo "You may need to source ~/.bashrc or restart terminal"
echo ""
echo "When you start Claude Code, tell it:"
echo "\"I'm running NixOS and need help fixing my configuration."
echo "The configs are at /etc/nixos/ and also in ~/nixos-config/ git repo."
echo "Please help me build a working Sway desktop by fixing package names"
echo "and commenting out broken packages. Start with the current errors"
echo "from 'sudo nixos-rebuild switch' and work through them systematically.\""