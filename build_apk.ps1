$ErrorActionPreference = 'Stop'

$toolingDir = "d:\MutthiMeter\.tooling"
$javaHome = "$toolingDir\jdk-21.0.4+7"
$sdkRoot = "$toolingDir\android-sdk"

$env:JAVA_HOME = $javaHome
$env:ANDROID_HOME = $sdkRoot
$env:ANDROID_SDK_ROOT = $sdkRoot
$env:PATH = "$javaHome\bin;$sdkRoot\platform-tools;C:\Program Files\nodejs;$env:PATH"

Write-Host "Building Android APK..."
Write-Host "JAVA_HOME = $env:JAVA_HOME"
Write-Host "ANDROID_HOME = $env:ANDROID_HOME"

Set-Location "d:\MutthiMeter\android"

# Run Gradle wrapper to assemble debug APK
cmd.exe /c "gradlew.bat assembleDebug --no-daemon"

$apkPath = "d:\MutthiMeter\android\app\build\outputs\apk\debug\app-debug.apk"
if (Test-Path $apkPath) {
    $item = Get-Item $apkPath
    Write-Host "=========================================="
    Write-Host "BUILD SUCCESSFUL! APK generated:"
    Write-Host "Path: $($item.FullName)"
    Write-Host "Filename: $($item.Name)"
    Write-Host "Size: $([math]::Round($item.Length / 1MB, 2)) MB ($($item.Length) bytes)"
    Write-Host "Last Modified: $($item.LastWriteTime)"
    Write-Host "=========================================="
} else {
    Write-Error "APK was not generated at expected path: $apkPath"
}
