#!/bin/bash
# Test packages on both platforms

set -e

PACKAGE_NAME="${1:-rgcidr}"

echo "🧪 Testing $PACKAGE_NAME on all platforms"

# Test Homebrew formula
echo "📦 Testing Homebrew formula..."
if command -v brew &> /dev/null; then
    echo "   Installing from source..."
    brew install --build-from-source "./homebrew/Formula/${PACKAGE_NAME}.rb" || {
        echo "❌ Homebrew installation failed"
        exit 1
    }
    
    echo "   Running audit..."
    brew audit --strict --new --online "homebrew/Formula/${PACKAGE_NAME}.rb" || {
        echo "⚠️  Homebrew audit warnings detected"
    }
    
    echo "   Testing functionality..."
    $PACKAGE_NAME --version || {
        echo "❌ Homebrew package test failed"
        exit 1
    }
    
    echo "✅ Homebrew formula tests passed"
else
    echo "⚠️  Homebrew not available, skipping Homebrew tests"
fi

# Test Scoop manifest (requires Windows or WSL with PowerShell and Scoop)
echo "🪣 Testing Scoop manifest..."
if command -v pwsh &> /dev/null && command -v scoop &> /dev/null; then
    pwsh -Command "
        try {
            scoop install \".\scoop\bucket\${PACKAGE_NAME}.json\"
            if (\$LASTEXITCODE -ne 0) {
                Write-Error 'Scoop installation failed'
                exit 1
            }
            
            & $PACKAGE_NAME --version
            if (\$LASTEXITCODE -ne 0) {
                Write-Error 'Scoop package test failed'
                exit 1
            }
            
            Write-Host '✅ Scoop manifest tests passed'
        } catch {
            Write-Error \"❌ Scoop test failed: \$_\"
            exit 1
        }
    "
else
    echo "⚠️  PowerShell/Scoop not available, skipping Scoop tests"
fi

echo "🎉 All available tests completed successfully!"