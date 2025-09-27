# Development Tools Package Repository

Cross-platform CLI tools available on both Homebrew (macOS/Linux) and Scoop (Windows).

## 🚀 Quick Installation

### macOS/Linux (Homebrew)
```bash
brew tap n-ae/packages
brew install rgcidr
```

### Windows (Scoop) 
```powershell
scoop bucket add packages https://github.com/n-ae/packages
scoop install rgcidr
```

## 📦 Available Packages

| Package | Version | Description | Platforms |
|---------|---------|-------------|-----------|
| **rgcidr** | v0.1.3 | High-performance IPv4/IPv6 CIDR filtering | macOS, Linux, Windows |

## 🔄 Updates

Both package managers support automatic updates:

### Homebrew
```bash
brew update && brew upgrade
```

### Scoop
```powershell
scoop update && scoop update *
```

## ✅ Verification

Test your installation:

```bash
# Check version
rgcidr --version

# Test basic functionality
echo "192.168.1.1" | rgcidr "192.168.0.0/16"
# Expected: 192.168.1.1

# Test with IPv6
echo "2001:db8::1" | rgcidr "2001:db8::/32" 
# Expected: 2001:db8::1
```

## 📚 Documentation

- [Installation Testing](docs/INSTALLATION_TEST.md) - Test installation instructions
- [Publishing Steps](docs/PUBLISHING_STEPS.md) - Complete publishing guide
- [Adding Packages](docs/ADDING_PACKAGES.md) - How to add new packages
- [Contributing](docs/CONTRIBUTING.md) - Contribution guidelines

## 🛠️ Development

### Adding New Packages
See [docs/ADDING_PACKAGES.md](docs/ADDING_PACKAGES.md) for detailed instructions.

### Testing
```bash
# Test Homebrew formulae (macOS/Linux)
./scripts/test-all.sh

# Test Scoop manifests (Windows)
.\scripts\test-all.ps1
```

### Updating Packages
```bash
# Update a specific package
./scripts/update-all.sh rgcidr 0.2.0

# Or trigger via GitHub Actions
gh workflow run update-packages.yml -f package=rgcidr -f version=0.2.0
```

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions welcome! Please read our [Contributing Guide](docs/CONTRIBUTING.md).
