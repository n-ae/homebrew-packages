# Development Tools Package Repository

Cross-platform CLI tools available on both Homebrew (macOS/Linux) and Scoop (Windows).

## 🚀 Quick Installation

### macOS/Linux (Homebrew)
```bash
brew tap yourusername/packages
brew install rgcidr
```

### Windows (Scoop) 
```powershell
scoop bucket add packages https://github.com/yourusername/packages
scoop install rgcidr
```

## 📦 Available Packages

| Package | Description | Platforms |
|---------|-------------|-----------|
| **rgcidr** | High-performance IPv4/IPv6 CIDR filtering | macOS, Linux, Windows |

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

## 📚 Documentation

- [Adding Packages](docs/ADDING_PACKAGES.md) - How to add new packages
- [Contributing](docs/CONTRIBUTING.md) - Contribution guidelines
- [Maintenance](docs/MAINTENANCE.md) - Package maintenance guide

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