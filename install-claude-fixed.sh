#!/bin/bash
set -e

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