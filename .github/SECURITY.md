# Security Policy

## Supported Versions

We actively support the latest versions of packages in this repository.

| Package | Version | Supported |
|---------|---------|-----------|
| rgcidr  | 0.1.3   | ✅        |
| rgcidr  | < 0.1.3 | ❌        |

## Reporting Security Vulnerabilities

If you discover a security vulnerability in any of the packages, please report it responsibly:

### For Package-Specific Vulnerabilities

Report directly to the upstream project:
- **rgcidr**: https://github.com/n-ae/rgcidr/security/advisories

### For Package Repository Vulnerabilities

Report issues with the package manifests, formulae, or automation:

1. **DO NOT** open a public issue
2. Use GitHub's private vulnerability reporting: https://github.com/n-ae/packages/security/advisories
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

## Security Measures

### Package Integrity
- All package manifests include SHA256 hashes
- Binary downloads are verified against checksums
- Source builds use tagged releases only
- Automated hash verification in CI/CD

### Repository Security
- All workflows use minimal required permissions
- No secrets stored in repository
- External dependencies pinned to specific versions
- Regular security audits of dependencies

### Build Security
- All builds use official GitHub Actions runners
- No custom Docker images or third-party runners
- Build artifacts verified before release
- Isolation between package builds

## Security Best Practices for Contributors

1. **Never commit secrets** or sensitive information
2. **Verify package hashes** before updating manifests
3. **Use signed commits** when possible
4. **Test security implications** of manifest changes
5. **Follow least privilege** principle for permissions

## Vulnerability Response

We aim to:
- Acknowledge reports within 24 hours
- Provide initial assessment within 72 hours
- Release fixes within 30 days for critical issues
- Coordinate with upstream projects for package vulnerabilities

## Scope

This security policy covers:
- Package manifests and formulae
- Automation scripts and workflows
- Repository infrastructure
- Documentation that could affect security

This policy does NOT cover:
- Vulnerabilities in the packaged software itself
- Issues with package managers (Homebrew, Scoop)
- Operating system or runtime vulnerabilities

For those issues, please report to the appropriate upstream projects.