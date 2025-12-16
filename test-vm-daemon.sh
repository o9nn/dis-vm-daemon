#!/bin/bash
# Mock vm-daemon script for testing the GitHub Action

set -e

VERSION="${1:-latest}"

echo "==================================="
echo "vm-daemon Mock Installation Script"
echo "==================================="
echo ""
echo "Download vm-daemon"
echo "Version: $VERSION"
echo ""

# Simulate download
mkdir -p /tmp/vm-daemon-download
tar czf /tmp/vm-daemon-download/vm-daemon.tar.gz -C /tmp . 2>/dev/null || echo "mock" > /tmp/vm-daemon-download/vm-daemon.tar.gz

echo "Verify vm-daemon.tar.gz: OK"
echo "✓ vm-daemon.tar.gz: OK"
echo ""

# Simulate installation
echo "Run 'vm-daemon install' command..."
mkdir -p "$HOME/.vm-daemon/bin"
cd /tmp/vm-daemon-download
tar xzf vm-daemon.tar.gz -C "$HOME/.vm-daemon/bin" 2>/dev/null || true

echo ""
echo "│ service: vm-daemon"
echo "│ process_id: $$"
echo "│ install_path: $HOME/.vm-daemon/bin"
echo ""

# Simulate VSCode check
echo "Ensuring VSCode is installed..."
echo ""
echo "│ component: ensureVSCodeInstalled"
echo "│ vscodePath: $HOME/.vm-daemon/bin/vm-daemon-*"
echo ""

mkdir -p "$HOME/.vm-daemon/bin/vm-daemon-vscode"
echo "✓ VSCode environment ready"
echo ""

# Simulate startup
echo "⣯ ... (animated)"
sleep 1
echo ""
echo "Startup completed"
echo "[Status] Starting vm-daemon..."
echo ""
echo "│ service: vm-daemon"
echo "│ status: running"
echo "│ process_id: $$"
echo "│ version: $VERSION"
echo ""
echo "✓ vm-daemon is ready and running"
