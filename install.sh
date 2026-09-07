#!/usr/bin/env bash
set -e

# Solana / Agave Native Linux ARM64 Installer
# Target: aarch64-unknown-linux-gnu

ARCH="$(uname -m)"
OS="$(uname -s)"

if [ "$OS" != "Linux" ]; then
    echo "Error: This installer is built specifically for Linux. Detected OS: $OS"
    exit 1
fi

if [ "$ARCH" != "aarch64" ] && [ "$ARCH" != "arm64" ]; then
    echo "Error: This installer is built specifically for ARM64 (aarch64). Detected architecture: $ARCH"
    echo "For x86_64, please use the official installer: https://release.anza.xyz/stable/install"
    exit 1
fi

VERSION="${SOLANA_ARM64_VERSION:-v1.18.26-arm64-preview}"
RELEASE_TAG="$VERSION"
INSTALL_DIR="$HOME/.local/share/solana/install/active_release"
BIN_DIR="$INSTALL_DIR/bin"
TAR_FILE="solana-release-aarch64-unknown-linux-gnu.tar.bz2"
DOWNLOAD_URL="https://github.com/coad1024-cmd/solana-arm64-linux/releases/download/${RELEASE_TAG}/${TAR_FILE}"
CHECKSUM_URL="${DOWNLOAD_URL}.sha256"

echo "=== Solana / Agave Native Linux ARM64 Installer ==="
echo "Target Architecture: aarch64-unknown-linux-gnu"
echo "Release Tag:         $RELEASE_TAG"
echo "Install Directory:   $INSTALL_DIR"
echo ""

mkdir -p "$INSTALL_DIR"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "--> Downloading $TAR_FILE..."
curl -# -L -f "$DOWNLOAD_URL" -o "$TMP_DIR/$TAR_FILE"

echo "--> Downloading SHA256 checksum..."
curl -s -L -f "$CHECKSUM_URL" -o "$TMP_DIR/$TAR_FILE.sha256"

echo "--> Verifying checksum integrity..."
(cd "$TMP_DIR" && sha256sum -c "$TAR_FILE.sha256")

echo "--> Extracting binaries to $INSTALL_DIR..."
tar -xjf "$TMP_DIR/$TAR_FILE" -C "$INSTALL_DIR" --strip-components=1

echo "--> Verifying binary execution..."
"$BIN_DIR/solana" --version

echo ""
echo "=== Installation Complete! ==="
echo "To add the Solana ARM64 binaries to your PATH, run:"
echo ""
echo "  export PATH=\"$BIN_DIR:\$PATH\""
echo ""
echo "Or add it permanently to your shell configuration:"
echo "  echo 'export PATH=\"$BIN_DIR:\$PATH\"' >> ~/.bashrc"
echo ""
