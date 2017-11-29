$ErrorActionPreference = 'Stop'

$packageName = 'ninja'
$url         = 'https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-win.zip'
$checksum    = 'C80313E6C26C0B9E0C241504718E2D8BBC2798B73429933ADF03FDC6D84F0E70'

$packageArgs = @{
  packageName    = $packageName
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
