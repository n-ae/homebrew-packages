#!/bin/bash
# Update packages across both Homebrew and Scoop platforms

set -e

PACKAGE_NAME="$1"
NEW_VERSION="$2"

if [ -z "$PACKAGE_NAME" ] || [ -z "$NEW_VERSION" ]; then
    echo "Usage: $0 <package-name> <new-version>"
    echo "Example: $0 rgcidr 0.2.0"
    exit 1
fi

echo "🚀 Updating $PACKAGE_NAME to version $NEW_VERSION"

# Update Homebrew formula
echo "📦 Updating Homebrew formula..."
./scripts/homebrew/update-formulae.sh "$PACKAGE_NAME" "$NEW_VERSION"

# Update Scoop manifest (requires Windows or WSL with PowerShell)
echo "🪣 Updating Scoop manifest..."
if command -v pwsh &> /dev/null; then
    pwsh -File ./scripts/scoop/update-manifests.ps1 -Package "$PACKAGE_NAME" -Version "$NEW_VERSION"
else
    echo "⚠️  PowerShell not available. Please run the Scoop update manually on Windows:"
    echo "   .\scripts\scoop\update-manifests.ps1 -Package '$PACKAGE_NAME' -Version '$NEW_VERSION'"
fi

echo "✅ Update completed for $PACKAGE_NAME v$NEW_VERSION"
echo ""
echo "📋 Next steps:"
echo "1. Test both platforms:"
echo "   macOS/Linux: brew install --build-from-source ./homebrew/Formula/$PACKAGE_NAME.rb"
echo "   Windows:     scoop install .\scoop\bucket\$PACKAGE_NAME.json"
echo "2. Commit and push changes"
echo "3. Tag release if needed"