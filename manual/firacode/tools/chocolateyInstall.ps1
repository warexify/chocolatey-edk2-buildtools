function Get-CurrentDirectory {
    $thisName = $MyInvocation.MyCommand.Name
    [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
}

$fontHelpersPath = (Join-Path (Get-CurrentDirectory) 'FontHelpers.ps1')
. $fontHelpersPath

$fontUrl = 'https://github.com/tonsky/FiraCode/releases/download/1.205/FiraCode_1.205.zip'
$checksumType = 'sha256'
$checksum = '85B2A6DE92B71EF0F7715CCA32D394484221EC978CB21E5228DC99978A7B7D8D'

$destination = Join-Path $Env:Temp 'FiraCode'

Install-ChocolateyZipPackage -PackageName 'FiraCode' -url $fontUrl -unzipLocation $destination -ChecksumType "$checksumType" -Checksum "$checksum"

$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

$fontFiles = Get-ChildItem $destination -Recurse -Filter *.otf

$commands = $fontFiles |
    ForEach-Object { Join-Path $fontsFolder.Self.Path $_.Name } |
    Where-Object { Test-Path $_ } |
    ForEach-Object { "Remove-SingleFont '$_' -Force;" }

$fontFiles |
    ForEach-Object { $commands += "Add-SingleFont '$($_.FullName)';" }

$toExecute = ". $fontHelpersPath;" + ($commands -join ';')
Start-ChocolateyProcessAsAdmin $toExecute

Remove-Item $destination -Recurse
