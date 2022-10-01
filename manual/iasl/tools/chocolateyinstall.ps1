$ErrorActionPreference = 'Stop'

$packageName = 'iasl'
$url = 'https://acpica.org/sites/acpica/files/iasl-win-20220331.zip'
$checksum = 'e501c152daf2d40763abaa8f6923e690252bbe4f3f9718d2b20298bca6ccc125'
$installDir = 'C:\ASL'

$packageArgs = @{
    packageName   = $packageName
    url           = $url
    checksum      = $checksum
    checksumType  = 'sha256'
    unzipLocation = $installDir
}

if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')) {  $installDir = $installDir -replace '^.|.$' }
    $parent = Split-Path $installDir
    mkdir -force $parent -ea 0 | out-null
}

Write-Host "Installing to '$installDir'"
Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPath $installDir -PathType 'Machine'

Install-ChocolateyEnvironmentVariable `
    -VariableName 'IASL_PREFIX' `
    -VariableValue $installDir `
    -VariableType 'Machine'
