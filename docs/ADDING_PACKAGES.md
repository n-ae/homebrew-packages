# Adding New Packages

This guide explains how to add new packages to the unified repository.

## Prerequisites

Before adding a package, ensure you have:

1. **GitHub Release**: Package has proper versioned releases
2. **Binary Artifacts**: Built for target platforms (Windows for Scoop, source for Homebrew)
3. **Checksums**: SHA256 hashes for all release artifacts
4. **License**: Proper license file
5. **Documentation**: Basic README with usage instructions

## Step 1: Create Homebrew Formula

Create `homebrew/Formula/<package-name>.rb`:

```ruby
class PackageName < Formula
  desc "Brief description of the package"
  homepage "https://github.com/n-ae/package-name"
  url "https://github.com/n-ae/package-name/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "SHA256_HASH_OF_SOURCE_TARBALL"
  license "MIT"
  
  depends_on "dependency" => :build  # if needed
  
  def install
    # Build and install commands
    system "make", "install", "PREFIX=#{prefix}"
    # or for Zig projects:
    # system "zig", "build", "-Doptimize=ReleaseFast"
    # bin.install "zig-out/bin/package-name"
  end
  
  test do
    assert_match version.to_s, shell_output("#{bin}/package-name --version")
  end
end
```

## Step 2: Create Scoop Manifest

Create `scoop/bucket/<package-name>.json`:

```json
{
    "version": "1.0.0",
    "description": "Brief description of the package",
    "homepage": "https://github.com/n-ae/package-name",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "https://github.com/n-ae/package-name/releases/download/v1.0.0/package-name-windows-x86_64.exe",
            "hash": "SHA256_HASH_OF_WINDOWS_BINARY",
            "bin": [
                ["package-name-windows-x86_64.exe", "package-name"]
            ]
        }
    },
    "checkver": {
        "github": "https://github.com/n-ae/package-name"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://github.com/n-ae/package-name/releases/download/v$version/package-name-windows-x86_64.exe"
            }
        }
    }
}
```

## Step 3: Get SHA256 Hashes

### For Homebrew (source tarball):
```bash
curl -L -o package.tar.gz https://github.com/n-ae/package-name/archive/refs/tags/v1.0.0.tar.gz
shasum -a 256 package.tar.gz
```

### For Scoop (Windows binary):
```bash
curl -L -o package.exe https://github.com/n-ae/package-name/releases/download/v1.0.0/package-name-windows-x86_64.exe
shasum -a 256 package.exe
```

## Step 4: Test Both Platforms

### Test Homebrew Formula:
```bash
brew install --build-from-source ./homebrew/Formula/package-name.rb
brew audit --strict --new --online ./homebrew/Formula/package-name.rb
package-name --version
```

### Test Scoop Manifest:
```powershell
scoop install .\scoop\bucket\package-name.json
package-name --version
```

## Step 5: Commit and Push

```bash
git add homebrew/Formula/package-name.rb scoop/bucket/package-name.json
git commit -m "Add package-name v1.0.0

- High-performance CLI tool for X
- Supports Windows, macOS, and Linux
- Available via Homebrew and Scoop"
git push origin main
```

## Step 6: Update Documentation

Add the new package to:

1. **README.md**: Update the packages table
2. **This guide**: Add any package-specific notes

## Automation

Once added, future updates can be automated:

```bash
# Manual update
./scripts/update-all.sh package-name 1.1.0

# GitHub Actions (triggered by releases)
gh workflow run update-packages.yml -f package=package-name -f version=1.1.0
```

## Best Practices

### ✅ Do:
- Use semantic versioning (v1.0.0, v1.1.0, etc.)
- Test on clean systems before committing
- Include comprehensive test blocks in formulae
- Use descriptive commit messages
- Keep manifests/formulae synchronized

### ❌ Don't:
- Mix different versions between platforms
- Forget to update SHA256 hashes
- Skip testing on target platforms
- Use platform-specific paths without checking
- Hardcode version numbers in URLs

## Template Files

Use the templates in `templates/` directory:

- `templates/homebrew-formula.rb.template` - Homebrew formula template
- `templates/scoop-manifest.json.template` - Scoop manifest template

## Troubleshooting

### Common Issues:

1. **Hash Mismatch**: Always verify SHA256 hashes match release artifacts exactly
2. **Build Failures**: Test formula on clean macOS/Linux systems
3. **Scoop Installation Fails**: Ensure Windows binary is properly cross-compiled
4. **Audit Failures**: Follow Homebrew's formula style guidelines
5. **Version Conflicts**: Use consistent versioning across all platforms

### Getting Help:

- **Homebrew**: [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- **Scoop**: [App Manifests Wiki](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests)
- **Repository Issues**: Open an issue in this repository
