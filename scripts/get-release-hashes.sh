#!/bin/bash
# Get SHA256 hashes from a GitHub release for package updates

set -e

REPO="n-ae/rgcidr"
VERSION="$1"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.1.2"
    exit 1
fi

echo "🔍 Getting SHA256 hashes for $REPO v$VERSION"

# Download checksums.txt from the release
CHECKSUMS_URL="https://github.com/$REPO/releases/download/v$VERSION/checksums.txt"

echo "📥 Downloading checksums from: $CHECKSUMS_URL"

if curl -L -f -s "$CHECKSUMS_URL" -o checksums.txt; then
    echo "✅ Downloaded checksums.txt"
    echo ""
    echo "📋 Available hashes:"
    cat checksums.txt
    echo ""
    
    # Extract specific hashes for package manifests
    WINDOWS_X64_HASH=$(grep "rgcidr-windows-x86_64.exe" checksums.txt | cut -d' ' -f1)
    WINDOWS_I386_HASH=$(grep "rgcidr-windows-i386.exe" checksums.txt | cut -d' ' -f1)
    SOURCE_HASH=""
    
    # Get source tarball hash (need to download and calculate)
    SOURCE_URL="https://github.com/$REPO/archive/refs/tags/v$VERSION.tar.gz"
    echo "📥 Downloading source tarball for hash calculation..."
    if curl -L -f -s "$SOURCE_URL" -o "source-v$VERSION.tar.gz"; then
        SOURCE_HASH=$(shasum -a 256 "source-v$VERSION.tar.gz" | cut -d' ' -f1)
        rm "source-v$VERSION.tar.gz"
        echo "✅ Source tarball hash: $SOURCE_HASH"
    else
        echo "⚠️  Could not download source tarball"
    fi
    
    echo ""
    echo "🔧 Package manifest updates needed:"
    echo ""
    
    if [ -n "$WINDOWS_X64_HASH" ]; then
        echo "Scoop manifest (scoop/bucket/rgcidr.json):"
        echo "  64bit hash: sha256:$WINDOWS_X64_HASH"
        if [ -n "$WINDOWS_I386_HASH" ]; then
            echo "  32bit hash: sha256:$WINDOWS_I386_HASH"
        fi
        echo ""
    fi
    
    if [ -n "$SOURCE_HASH" ]; then
        echo "Homebrew formula (homebrew/Formula/rgcidr.rb):"
        echo "  Source hash: $SOURCE_HASH"
        echo ""
    fi
    
    echo "🤖 Auto-update command:"
    echo "  ./scripts/update-all.sh rgcidr $VERSION"
    
    # Clean up
    rm -f checksums.txt
    
else
    echo "❌ Failed to download checksums. Is the release published?"
    echo "   Release URL: https://github.com/$REPO/releases/tag/v$VERSION"
    exit 1
fi