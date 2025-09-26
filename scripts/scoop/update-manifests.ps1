# Update Scoop manifests with new version
param(
    [Parameter(Mandatory=$true)]
    [string]$Package,
    
    [Parameter(Mandatory=$true)]
    [string]$Version
)

$ErrorActionPreference = "Stop"

$ManifestFile = "scoop\bucket\$Package.json"

if (-not (Test-Path $ManifestFile)) {
    Write-Error "❌ Manifest file not found: $ManifestFile"
    exit 1
}

Write-Host "🪣 Updating Scoop manifest: $Package"

# Read current manifest
$manifest = Get-Content $ManifestFile | ConvertFrom-Json

# Extract GitHub info
$homepage = $manifest.homepage
if ($homepage -match "github\.com/([^/]+)/([^/]+)") {
    $githubUser = $matches[1]
    $repoName = $matches[2]
} else {
    Write-Error "❌ Could not extract GitHub info from homepage: $homepage"
    exit 1
}

# Update version
$manifest.version = $Version

# Update URLs and get hashes for each architecture
foreach ($arch in $manifest.architecture.PSObject.Properties.Name) {
    $archData = $manifest.architecture.$arch
    
    # Determine binary name from current URL
    $currentUrl = $archData.url
    if ($currentUrl -match "([^/]+\.exe)$") {
        $binaryName = $matches[1]
    } else {
        Write-Error "❌ Could not extract binary name from URL: $currentUrl"
        exit 1
    }
    
    # Update URL
    $newUrl = "https://github.com/$githubUser/$repoName/releases/download/v$Version/$binaryName"
    $archData.url = $newUrl
    
    # Download and get hash
    Write-Host "📥 Downloading $arch binary: $newUrl"
    $tempFile = [System.IO.Path]::GetTempFileName()
    
    try {
        Invoke-WebRequest -Uri $newUrl -OutFile $tempFile -ErrorAction Stop
        $hash = (Get-FileHash -Path $tempFile -Algorithm SHA256).Hash.ToLower()
        $archData.hash = "sha256:$hash"
        Write-Host "🔐 New SHA256 for $arch`: $hash"
    } catch {
        Write-Error "❌ Failed to download $arch binary. Please check if release v$Version exists."
        exit 1
    } finally {
        Remove-Item $tempFile -ErrorAction SilentlyContinue
    }
}

# Update autoupdate URLs
if ($manifest.autoupdate -and $manifest.autoupdate.architecture) {
    foreach ($arch in $manifest.autoupdate.architecture.PSObject.Properties.Name) {
        $autoData = $manifest.autoupdate.architecture.$arch
        if ($autoData.url) {
            $autoData.url = $autoData.url -replace "v\$version", "v`$version"
        }
    }
}

# Save updated manifest
$manifest | ConvertTo-Json -Depth 10 | Set-Content $ManifestFile -Encoding UTF8

Write-Host "✅ Updated $ManifestFile"
Write-Host "   Version: $Version"