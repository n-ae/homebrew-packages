#!/bin/bash
# Update Homebrew formulae with new version

set -e

PACKAGE_NAME="$1"
NEW_VERSION="$2"

if [ -z "$PACKAGE_NAME" ] || [ -z "$NEW_VERSION" ]; then
    echo "Usage: $0 <package-name> <new-version>"
    exit 1
fi

FORMULA_FILE="homebrew/Formula/${PACKAGE_NAME}.rb"

if [ ! -f "$FORMULA_FILE" ]; then
    echo "❌ Formula file not found: $FORMULA_FILE"
    exit 1
fi

echo "📦 Updating Homebrew formula: $PACKAGE_NAME"

# Get new source tarball hash
GITHUB_USER=$(grep 'homepage.*github.com' "$FORMULA_FILE" | sed 's/.*github.com\/\([^/]*\)\/.*/\1/')
if [ -z "$GITHUB_USER" ]; then
    echo "❌ Could not extract GitHub username from formula"
    exit 1
fi

TARBALL_URL="https://github.com/${GITHUB_USER}/${PACKAGE_NAME}/archive/refs/tags/v${NEW_VERSION}.tar.gz"
echo "📥 Downloading tarball: $TARBALL_URL"

# Download and get hash
TEMP_FILE=$(mktemp)
if curl -L -o "$TEMP_FILE" "$TARBALL_URL"; then
    NEW_HASH=$(shasum -a 256 "$TEMP_FILE" | cut -d' ' -f1)
    rm "$TEMP_FILE"
    echo "🔐 New SHA256: $NEW_HASH"
else
    echo "❌ Failed to download tarball. Please check if release v$NEW_VERSION exists."
    rm -f "$TEMP_FILE"
    exit 1
fi

# Update formula
echo "✏️  Updating formula..."
sed -i.bak \
    -e "s/archive\/refs\/tags\/v[0-9.]*\.tar\.gz/archive\/refs\/tags\/v${NEW_VERSION}.tar.gz/" \
    -e "s/sha256 \"[^\"]*\"/sha256 \"$NEW_HASH\"/" \
    "$FORMULA_FILE"

rm "${FORMULA_FILE}.bak"

echo "✅ Updated $FORMULA_FILE"
echo "   Version: $NEW_VERSION"
echo "   SHA256:  $NEW_HASH"