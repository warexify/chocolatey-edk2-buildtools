function Get-CurrentDirectory {
    $thisName = $MyInvocation.MyCommand.Name
    [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
}

$fontHelpersPath = (Join-Path (Get-CurrentDirectory) 'FontHelpers.ps1')
. $fontHelpersPath

$fontUrl = 'https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip'
$checksumType = 'sha256'
$checksum = '837B4A9352FCE32AD7F298FBF155AF1DA5B6F3F8DBD995EB63FDD8E82117E4AE'

$destination = Join-Path $Env:Temp 'NotoFonts'

Install-ChocolateyZipPackage -PackageName 'NotoFonts' -url $fontUrl -unzipLocation $destination -ChecksumType "$checksumType" -Checksum "$checksum"

$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.Namespace(0x14)

$fontFiles = (Get-ChildItem $destination -Recurse -Filter *.otf) +
(Get-ChildItem $destination -Recurse -Filter *.ttf)

$fss = for ($i = 0; $i -lt $fontFiles.length; $i += 10) {
    , ($fontFiles[$i .. ($i + 9)])
}

for ($i = 0; $i -lt $fss.length; $i += 1) {
    $fs = $fss[$i];
    $commands = $fs |
        ForEach-Object { Join-Path $fontsFolder.Self.Path $_.Name } |
        Where-Object { Test-Path $_ } |
        ForEach-Object { "Remove-SingleFont '$_' -Force;" }
    $fs |
        ForEach-Object { $commands += "Add-SingleFont '$($_.FullName)';" }
    $toExecute = ". $fontHelpersPath;" + ($commands -join ';')
    Start-ChocolateyProcessAsAdmin $toExecute
}

Remove-Item $destination -Recurse
