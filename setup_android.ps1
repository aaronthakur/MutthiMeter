param()

$ErrorActionPreference = 'Stop'

$toolingDir = "d:\MutthiMeter\.tooling"
$javaHome = "$toolingDir\jdk-17.0.12+7"
$sdkRoot = "$toolingDir\android-sdk"
$sdkManager = "$sdkRoot\cmdline-tools\latest\bin\sdkmanager.bat"

$env:JAVA_HOME = $javaHome
$env:ANDROID_HOME = $sdkRoot
$env:ANDROID_SDK_ROOT = $sdkRoot
$env:PATH = "$javaHome\bin;$sdkRoot\cmdline-tools\latest\bin;$sdkRoot\platform-tools;$env:PATH"

Write-Host "Installing platforms;android-35 and build-tools;35.0.0..."

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $sdkManager
$psi.Arguments = "--sdk_root=`"$sdkRoot`" `"platforms;android-35`" `"build-tools;35.0.0`""
$psi.UseShellExecute = $false
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.EnvironmentVariables["JAVA_HOME"] = $javaHome

$proc = [System.Diagnostics.Process]::Start($psi)

# Feed yes to license prompts
for ($i = 0; $i -lt 50; $i++) {
    $proc.StandardInput.WriteLine("y")
}
$proc.StandardInput.Flush()
$proc.StandardInput.Close()

$stdout = $proc.StandardOutput.ReadToEnd()
$stderr = $proc.StandardError.ReadToEnd()
$proc.WaitForExit()

Write-Host "Output: $stdout"
if ($stderr) {
    Write-Host "Errors: $stderr"
}

Write-Host "sdkmanager exit code: $($proc.ExitCode)"
