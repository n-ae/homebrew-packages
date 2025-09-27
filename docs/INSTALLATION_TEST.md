# Installation Testing Guide

Test rgcidr installation from published package managers.

## ✅ Testing Homebrew Installation (macOS/Linux)

```bash
# Add the tap
brew tap n-ae/packages

# Install rgcidr
brew install rgcidr

# Verify installation
rgcidr --version
# Expected output: rgcidr v0.1.3

# Test basic functionality
echo "192.168.1.1" | rgcidr "192.168.0.0/16"
# Expected output: 192.168.1.1

echo "10.0.0.1" | rgcidr "192.168.0.0/16"
# Expected output: (no output - not in range)

# Test IPv6 support
echo "2001:db8::1" | rgcidr "2001:db8::/32"
# Expected output: 2001:db8::1
```

## ✅ Testing Scoop Installation (Windows)

```powershell
# Add the bucket
scoop bucket add packages https://github.com/n-ae/packages

# Install rgcidr
scoop install rgcidr

# Verify installation
rgcidr --version
# Expected output: rgcidr v0.1.3

# Test basic functionality
echo "192.168.1.1" | rgcidr "192.168.0.0/16"
# Expected output: 192.168.1.1

echo "10.0.0.1" | rgcidr "192.168.0.0/16"
# Expected output: (no output - not in range)

# Test IPv6 support
echo "2001:db8::1" | rgcidr "2001:db8::/32"
# Expected output: 2001:db8::1
```

## ✅ Testing Direct Installation

### Homebrew Direct Install
```bash
brew install n-ae/packages/rgcidr
```

### Scoop Direct Install
```powershell
scoop install n-ae/packages/rgcidr
```

## 🔄 Testing Updates

### Homebrew Updates
```bash
brew update
brew upgrade rgcidr
```

### Scoop Updates
```powershell
scoop update
scoop update rgcidr
```

## 🧪 Advanced Testing

### Test with Log Files
```bash
# Create test log file
cat > test.log << EOF
192.168.1.1 - - [01/Jan/2024:00:00:01 +0000] "GET / HTTP/1.1" 200
10.0.0.1 - - [01/Jan/2024:00:00:02 +0000] "GET /test HTTP/1.1" 404
172.16.0.1 - - [01/Jan/2024:00:00:03 +0000] "POST /api HTTP/1.1" 200
203.0.113.1 - - [01/Jan/2024:00:00:04 +0000] "GET /public HTTP/1.1" 200
EOF

# Filter private IP ranges
rgcidr "192.168.0.0/16,10.0.0.0/8,172.16.0.0/12" test.log
# Expected: Lines with 192.168.1.1, 10.0.0.1, and 172.16.0.1

# Filter public IPs only
rgcidr -v "192.168.0.0/16,10.0.0.0/8,172.16.0.0/12" test.log
# Expected: Line with 203.0.113.1
```

### Performance Test
```bash
# Generate large test file
seq 1 1000 | while read i; do echo "192.168.$((i % 256)).$((i % 256))"; done > large_test.txt

# Time the filtering
time rgcidr "192.168.0.0/16" large_test.txt | wc -l
# Should complete quickly and show count of matching IPs
```

## 📊 Success Criteria

Installation is successful when:

- [ ] **Package manager accepts installation** without errors
- [ ] **Version command works**: `rgcidr --version` shows v0.1.3
- [ ] **Basic IPv4 filtering works** with expected output
- [ ] **IPv6 filtering works** with expected output  
- [ ] **Help command works**: `rgcidr --help` shows usage
- [ ] **Performance is reasonable** on test files
- [ ] **Updates work** through package manager

## 🚨 Troubleshooting

### Common Issues

**"command not found: rgcidr"**
- Check if package manager PATH is configured correctly
- Try `which rgcidr` to locate the binary
- Restart terminal/shell

**"Permission denied"**
- Package managers should handle permissions automatically
- Check if installation directory is writable

**"Hash mismatch" (Scoop)**
- Package manifest may have incorrect SHA256 hash
- Report issue to repository

**"Formula/manifest not found"**
- Ensure tap/bucket was added correctly
- Try refreshing: `brew update` or `scoop update`

### Getting Help

- **Package Issues**: https://github.com/n-ae/packages/issues
- **rgcidr Issues**: https://github.com/n-ae/rgcidr/issues
- **Homebrew Support**: https://docs.brew.sh/
- **Scoop Support**: https://scoop.sh/

## 📈 Reporting Success

When testing succeeds, you can:

1. **Star the repositories** to show support
2. **Share usage examples** in discussions
3. **Report successful platforms** in issues
4. **Suggest improvements** via pull requests

Thank you for testing rgcidr! 🎉