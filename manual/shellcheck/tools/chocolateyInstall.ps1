$tools = Split-Path $MyInvocation.MyCommand.Definition
$content = Join-Path (Split-Path $tools) 'content'
$original = Join-Path $content 'shellcheck-latest.exe'
$target = Join-Path $content 'shellcheck.exe'

Install-ChocolateyZipPackage `
    -PackageName 'shellcheck' `
    -Url 'https://shellcheck.storage.googleapis.com/shellcheck-latest.zip' `
    -Checksum '49c4ca6bba48185f53ddcc334967e7292f20a9b20d1cbe31c71bee71cfdd4e770be89f027d4044dda4159323ddfd3055bfb1e50e4c81d78375da9894e577f41f' `
    -ChecksumType 'SHA512' `
    -UnzipLocation $content

Rename-Item -Path $original -NewName $target -Force | Out-Null
