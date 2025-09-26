# Publishing Steps for rgcidr

Complete step-by-step guide for publishing rgcidr to package managers.

## Prerequisites ✅

- [x] **Unified packages repository** created at `~/dev/packages`
- [x] **Package manifests** created (Homebrew formula + Scoop manifest)
- [x] **Release workflow** enhanced with checksum generation
- [x] **Package manager URLs** updated in rgcidr README

## Step 3: Create GitHub Release

### 3.1 Push rgcidr Repository Changes

```bash
cd ~/dev/rgcidr

# Ensure all changes are committed
git add .
git commit -m "Prepare for package manager publishing"
git push origin main
```

### 3.2 Trigger Release

The release will be automatically created when changes are pushed to main, since the current version (0.1.2) doesn't have a release yet.

**Monitor the release process:**
- Release workflow: https://github.com/n-ae/rgcidr/actions
- Release page: https://github.com/n-ae/rgcidr/releases

**The workflow will:**
1. ✅ Build binaries for all platforms (Windows x64/x86, macOS, Linux)
2. ✅ Generate SHA256 checksums
3. ✅ Create GitHub release with all artifacts
4. ✅ Publish release automatically

### 3.3 Verify Release

Once complete, verify the release contains:
- [ ] `rgcidr-windows-x86_64.exe` 
- [ ] `rgcidr-windows-i386.exe`
- [ ] `rgcidr-linux-x86_64`
- [ ] `rgcidr-linux-aarch64` 
- [ ] `rgcidr-macos-x86_64`
- [ ] `rgcidr-macos-aarch64`
- [ ] `checksums.txt`

## Step 4: Update Package Repository

### 4.1 Get Release Hashes

```bash
cd ~/dev/packages

# Get hashes for the release
./scripts/get-release-hashes.sh 0.1.2
```

This will show the SHA256 hashes needed for package manifests.

### 4.2 Update Package Manifests

**Option A: Automatic Update (Recommended)**
```bash
# This updates both Homebrew and Scoop manifests automatically
./scripts/update-all.sh rgcidr 0.1.2
```

**Option B: Manual Update**

**Update Scoop manifest:**
```bash
./scripts/scoop/update-manifests.ps1 -Package rgcidr -Version 0.1.2
```

**Update Homebrew formula:**
```bash
./scripts/homebrew/update-formulae.sh rgcidr 0.1.2
```

### 4.3 Test Package Installations

**Test locally before pushing:**

```bash
# Test Homebrew formula (macOS/Linux)
brew install --build-from-source ./homebrew/Formula/rgcidr.rb
brew test rgcidr
rgcidr --version

# Test Scoop manifest (Windows)
scoop install .\scoop\bucket\rgcidr.json
rgcidr --version
```

### 4.4 Commit and Push Package Updates

```bash
cd ~/dev/packages

git add homebrew/Formula/rgcidr.rb scoop/bucket/rgcidr.json
git commit -m "Update rgcidr to v0.1.2

- Update Homebrew formula with new SHA256 hash
- Update Scoop manifest with new binary hashes  
- Ready for user installation

🤖 Generated with Claude Code"

git push origin main
```

## Step 5: Publish Packages Repository

### 5.1 Create GitHub Repository

```bash
cd ~/dev/packages

# Create the repository on GitHub
gh repo create n-ae/packages --public --description "Cross-platform CLI tools for Homebrew and Scoop"

# Push all content
git remote add origin https://github.com/n-ae/packages.git
git push -u origin main
```

### 5.2 Configure Repository

**Set up repository settings:**
1. **Description**: "Cross-platform CLI tools for Homebrew and Scoop"
2. **Topics**: `homebrew`, `scoop`, `cli-tools`, `package-manager`, `rgcidr`
3. **License**: MIT License

**Enable GitHub Actions:**
- All workflows should run automatically for testing

## Step 6: User Installation Testing

### 6.1 Test End-to-End Installation

**Homebrew (macOS/Linux):**
```bash
# Add tap and install
brew tap n-ae/packages
brew install rgcidr

# Test functionality
rgcidr --version
echo "192.168.1.1" | rgcidr "192.168.0.0/16"
```

**Scoop (Windows):**
```powershell
# Add bucket and install
scoop bucket add packages https://github.com/n-ae/packages
scoop install rgcidr

# Test functionality  
rgcidr --version
echo "192.168.1.1" | rgcidr "192.168.0.0/16"
```

### 6.2 Test Auto-Updates

**Scoop auto-update:**
```powershell
scoop checkver rgcidr
scoop update rgcidr
```

**Homebrew updates:**
```bash
brew update
brew upgrade rgcidr
```

## Step 7: Documentation and Announcements

### 7.1 Update Documentation

**Update rgcidr README with final instructions:**
- ✅ Package manager installation commands
- ✅ Links to packages repository
- ✅ Installation verification steps

**Update packages repository README:**
- ✅ Clear installation instructions
- ✅ Package table with rgcidr
- ✅ Contributing guidelines

### 7.2 Create Release Announcement

Consider creating:
- [ ] **GitHub Release Notes** with installation instructions
- [ ] **Social media announcement** (Twitter, Reddit, etc.)
- [ ] **Community posts** (Zig community, dev forums)

## Troubleshooting

### Common Issues

**Hash Mismatches:**
- Verify release contains `checksums.txt`
- Re-run hash script: `./scripts/get-release-hashes.sh 0.1.2`

**Installation Failures:**
- Test locally with `brew install --build-from-source`
- Check formula syntax with `brew audit`

**Workflow Failures:**
- Check GitHub Actions logs
- Verify Zig version compatibility
- Ensure all tests pass

### Getting Help

- **Repository Issues**: https://github.com/n-ae/packages/issues
- **Homebrew Support**: https://docs.brew.sh/
- **Scoop Support**: https://scoop.sh/

## Success Criteria ✅

Publishing is complete when:

- [ ] **GitHub release** created with all binaries and checksums
- [ ] **Package manifests** updated with correct SHA256 hashes  
- [ ] **Packages repository** published on GitHub
- [ ] **User installation** works on all platforms
- [ ] **Auto-updates** configured and tested
- [ ] **Documentation** updated with installation instructions

**Final verification commands:**

```bash
# Homebrew
brew tap n-ae/packages && brew install rgcidr && rgcidr --version

# Scoop  
scoop bucket add packages https://github.com/n-ae/packages && scoop install rgcidr && rgcidr --version
```

When both commands work successfully, rgcidr is officially published! 🎉