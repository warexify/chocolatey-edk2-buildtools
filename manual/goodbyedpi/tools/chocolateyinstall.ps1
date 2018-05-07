if (Get-OSArchitectureWidth -eq 64) {
$subfolder = '_64'
}
Install-ChocolateyZipPackage "$env:chocolateyPackageName" 'https://github.com/ValdikSS/GoodbyeDPI/releases/download/0.1.5rc1/goodbyedpi-0.1.5rc1.zip' "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" -Checksum '6d93cb20be60143581c4a35de962a674f804e8ee4dfa4ebf079971317b399525' -ChecksumType 'sha256' -SpecificFolder "goodbyedpi-0.1.5rc1/x86$subfolder"
