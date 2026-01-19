# Build Wartales_repack_font into a Windows EXE using PyInstaller
# Usage: Open PowerShell (x86/x64 matching your Python) and run:
#   ./build_exe.ps1
# This script will create a single-file EXE in the `dist/` folder.

param(
    [switch]$OneFile = $true,
    [string]$Name = "Wartales_repack_font",
    [string[]]$AddData = @()
)

# Ensure pyinstaller is available
if (-not (Get-Command pyinstaller -ErrorAction SilentlyContinue)) {
    Write-Host "PyInstaller not found. Installing into the active environment..." -ForegroundColor Yellow
    python -m pip install --upgrade pyinstaller
}

$projRoot = (Get-Location).Path
$entry = "Wartales_repack_font.py"

# On Windows the separator for --add-data is ';'
$addDataFlags = @()
foreach ($a in $AddData) {
    $addDataFlags += "--add-data"; $addDataFlags += $a
}

if ($OneFile) {
    $pyArgs = @("--clean", "--onefile", "--console", "--name", $Name) + $addDataFlags + @($entry)
} else {
    $pyArgs = @("--clean", "--onedir", "--console", "--name", $Name) + $addDataFlags + @($entry)
}

Write-Host "Building $entry -> dist\$Name.exe" -ForegroundColor Green
pyinstaller @pyArgs

Write-Host "Build finished. See dist\ for the result." -ForegroundColor Green

<#
Tips:
- If you need to bundle folders such as `_tools_/txt2fnt` or `_script_`, pass them as `--add-data` entries in the form "<src>;<dest>". Example:
  ./build_exe.ps1 -AddData "_tools_/txt2fnt;_tools_/txt2fnt" "_script_;_script_"
- This script does not attempt to bundle platform-specific binary tools. It's typical to keep those as external dependencies and provide instructions in the README.
#>


# pyinstaller --onefile --windowed Wartales_repack_font_gui.py
# also builds a GUI version
pyinstaller --onefile --windowed Wartales_repack_font_gui.py

Write-Host "GUI Build finished. See dist\ for the result." -ForegroundColor Green



# Copy helper folders into the dist directory (copy contents, avoid nested duplicates)
$distPath = Join-Path $projRoot "dist"
$targetTools = Join-Path $distPath "_tools_"
if (Test-Path $targetTools) { Remove-Item -Recurse -Force $targetTools }
New-Item -ItemType Directory -Path $targetTools | Out-Null
Copy-Item -Path (Join-Path $projRoot "_tools_\*") -Destination $targetTools -Recurse -Force

$targetScript = Join-Path $distPath "_script_"
if (Test-Path $targetScript) { Remove-Item -Recurse -Force $targetScript }
New-Item -ItemType Directory -Path $targetScript | Out-Null
Copy-Item -Path (Join-Path $projRoot "_script_\*") -Destination $targetScript -Recurse -Force

Write-Host "Copied helper folders into dist" -ForegroundColor Green

# Zip all files in the dist folder and save the zip file in build folder (use Python script if available)
$buildPath = Join-Path $projRoot "build"
if (-not (Test-Path $buildPath)) {
    New-Item -ItemType Directory -Path $buildPath | Out-Null
}

$zipScript = Join-Path $projRoot "zip_build_bundle.py"
# try to find a Python executable (python, py)
$pythonCmd = $null
if (Get-Command python -ErrorAction SilentlyContinue) { $pythonCmd = "python" }
elseif (Get-Command py -ErrorAction SilentlyContinue) { $pythonCmd = "py" }

if ($pythonCmd -and (Test-Path $zipScript)) {
    Write-Host "Using zip_build_bundle.py to create zip" -ForegroundColor Green
    & $pythonCmd $zipScript --dist $distPath --build $buildPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "zip_build_bundle.py failed (exit $LASTEXITCODE), falling back to Compress-Archive" -ForegroundColor Yellow
        # fallback to Compress-Archive with ASCII-safe filename
        $zipBaseName = "Wartales_repack_zh.zip"
        $zipFile = Join-Path $buildPath $zipBaseName
        if (Test-Path $zipFile) { Remove-Item $zipFile -Force }
        Compress-Archive -Path (Join-Path $distPath "*") -DestinationPath $zipFile -Force -CompressionLevel Optimal
        Write-Host "Packaged build into $zipFile" -ForegroundColor Green
    } else {
        Write-Host "Packaged build via zip_build_bundle.py" -ForegroundColor Green
    }
} else {
    Write-Host "zip_build_bundle.py not found or Python missing; using Compress-Archive fallback" -ForegroundColor Yellow
    $zipBaseName = "Wartales_repack_zh.zip"
    $zipFile = Join-Path $buildPath $zipBaseName
    if (Test-Path $zipFile) { Remove-Item $zipFile -Force }
    Compress-Archive -Path (Join-Path $distPath "*") -DestinationPath $zipFile -Force -CompressionLevel Optimal
    Write-Host "Packaged build into $zipFile" -ForegroundColor Green
}