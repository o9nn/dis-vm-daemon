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

# Simulate download with proper tarball structure
mkdir -p /tmp/vm-daemon-download
cd /tmp/vm-daemon-download
mkdir -p vm-daemon-mock/bin
echo "vm-daemon-$VERSION" > vm-daemon-mock/bin/vm-daemon
tar czf vm-daemon.tar.gz vm-daemon-mock/
rm -rf vm-daemon-mock

echo "Verify vm-daemon.tar.gz: OK"
echo "✓ vm-daemon.tar.gz: OK"
echo ""

# Simulate installation
echo "Run 'vm-daemon install' command..."
mkdir -p "$HOME/.vm-daemon/bin"
cd /tmp/vm-daemon-download
if tar xzf vm-daemon.tar.gz -C "$HOME/.vm-daemon/bin" 2>/dev/null; then
  echo "✓ Extraction completed"
else
  echo "⚠ Extraction failed, creating minimal structure"
  mkdir -p "$HOME/.vm-daemon/bin/vm-daemon-mock"
fi

echo ""
echo "│ service: vm-daemon"
echo "│ process_id: $$"
echo "│ install_path: $HOME/.vm-daemon/bin"
echo ""

# Simulate VSCode check
echo "Ensuring VSCode is installed..."
echo ""
echo "│ component: ensureVSCodeInstalled"

mkdir -p "$HOME/.vm-daemon/bin/vm-daemon-vscode"
VSCODE_PATH="$HOME/.vm-daemon/bin/vm-daemon-vscode"
echo "│ vscodePath: $VSCODE_PATH"
echo ""

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
