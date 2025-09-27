# Contributing Guide

Thank you for your interest in contributing to our public package repository!

**🔒 Security Notice**: This is a public repository. Please review our [Security Policy](../.github/SECURITY.md) before contributing.

## Ways to Contribute

- **Add new packages** - Submit formulae/manifests for useful CLI tools
- **Update existing packages** - Keep packages current with latest releases  
- **Improve automation** - Enhance CI/CD workflows and scripts
- **Fix bugs** - Report and fix issues with package installations
- **Documentation** - Improve guides and documentation

## Before Contributing

1. **Check existing issues** - Search for similar requests or problems
2. **Verify package criteria** - Ensure tools meet our inclusion standards
3. **Test thoroughly** - Verify packages work on target platforms

## Package Inclusion Criteria

We accept packages that are:

- **Open source** with clear licensing
- **Cross-platform** or serve a specific platform need
- **Actively maintained** with regular releases
- **Useful to developers** - development tools, utilities, CLI apps
- **Well-documented** with clear usage instructions

## Contribution Process

### Adding New Packages

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b add-package-name`
3. **Follow the [Adding Packages Guide](ADDING_PACKAGES.md)**
4. **Test on both platforms** (Homebrew and Scoop where applicable)
5. **Submit a pull request** with detailed description

### Updating Existing Packages

1. **Use automation when possible**: `./scripts/update-all.sh package-name version`
2. **For manual updates**, follow the same testing process as new packages
3. **Verify hashes** match the actual release artifacts
4. **Test installation** on clean systems

### Pull Request Guidelines

#### Required Information:
- **Package name and version**
- **Brief description** of what the package does
- **Testing evidence** - screenshots or logs showing successful installation
- **Platform coverage** - which platforms were tested

#### PR Title Format:
```
Add package-name v1.0.0
Update package-name to v1.1.0  
Fix package-name installation issue
```

#### PR Description Template:
```markdown
## Package Information
- **Name**: package-name
- **Version**: 1.0.0
- **Homepage**: https://github.com/user/repo
- **License**: MIT

## Changes Made
- [ ] Added Homebrew formula
- [ ] Added Scoop manifest  
- [ ] Updated existing package
- [ ] Fixed installation issue

## Testing
- [ ] Tested on macOS (Homebrew)
- [ ] Tested on Linux (Homebrew)
- [ ] Tested on Windows (Scoop)

## Additional Notes
Any special considerations or platform-specific notes.
```

## Development Setup

### Prerequisites
- **Git** for version control
- **Homebrew** (macOS/Linux) for testing formulae
- **Scoop** (Windows) for testing manifests
- **PowerShell** for Windows-specific scripts

### Local Testing

```bash
# Clone your fork
git clone https://github.com/n-ae/packages
cd packages

# Test Homebrew formulae
brew install --build-from-source ./homebrew/Formula/package-name.rb
brew audit --strict --new --online ./homebrew/Formula/package-name.rb

# Test Scoop manifests (Windows/WSL)
scoop install .\scoop\bucket\package-name.json
```

## Code Style

### Homebrew Formulae
- Follow [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Use 2-space indentation
- Include comprehensive test blocks
- Add dependencies only when necessary

### Scoop Manifests
- Follow [Scoop App Manifests](https://github.com/ScoopInstaller/Scoop/wiki/App-Manifests) guidelines
- Use 4-space indentation for JSON
- Include autoupdate configurations
- Add helpful notes for users

### Scripts
- **Shell scripts**: Use `#!/bin/bash` and `set -e`
- **PowerShell scripts**: Include error handling with `$ErrorActionPreference = "Stop"`
- **Comment complex logic** and include usage examples
- **Make scripts executable**: `chmod +x script.sh`

## Automated Testing

All contributions are automatically tested via GitHub Actions:

- **Homebrew formulae** tested on macOS and Linux
- **Scoop manifests** tested on Windows
- **Audit checks** for style and best practices
- **Functionality tests** to verify package installation

## Release Process

1. **Automated updates** triggered by upstream releases
2. **Manual updates** via workflow dispatch or scripts
3. **Testing phase** on all supported platforms  
4. **Merge and deploy** after successful validation

## Security Guidelines

**🔒 Important**: This is a public repository. Follow these security practices:

### ✅ **Do:**
- Verify SHA256 hashes against official releases
- Use HTTPS URLs for all downloads
- Reference only official, maintained repositories
- Test packages in isolated environments
- Report security issues privately (see [Security Policy](../.github/SECURITY.md))

### ❌ **Never:**
- Commit API keys, tokens, or secrets
- Include personal credentials or paths
- Reference private or internal repositories
- Use unverified download URLs
- Hardcode sensitive configuration

## Communication

- **Issues**: Report bugs and feature requests
- **Discussions**: Ask questions and share ideas
- **Pull Requests**: Submit contributions with detailed descriptions
- **Security**: Follow our [Security Policy](../.github/SECURITY.md) for vulnerabilities

## Getting Help

### Documentation
- [Adding Packages Guide](ADDING_PACKAGES.md)
- [Maintenance Guide](MAINTENANCE.md)
- [Homebrew Documentation](https://docs.brew.sh/)
- [Scoop Documentation](https://github.com/ScoopInstaller/Scoop/wiki)

### Common Issues
- **Hash mismatches**: Always verify SHA256 hashes
- **Build failures**: Test on clean systems
- **Audit failures**: Follow platform style guides
- **Permission issues**: Ensure scripts are executable

## Code of Conduct

- **Be respectful** and professional
- **Help others** learn and contribute
- **Follow platform conventions** and best practices
- **Test thoroughly** before submitting
- **Document your changes** clearly

Thank you for contributing to making great tools more accessible!
