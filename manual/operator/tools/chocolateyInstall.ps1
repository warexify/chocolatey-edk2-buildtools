function Get-CurrentDirectory {
    $thisName = $MyInvocation.MyCommand.Name
    [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
}

$fontHelpersPath = (Join-Path (Get-CurrentDirectory) 'FontHelpers.ps1')
. $fontHelpersPath

$font = 'C:\Users\warexify\Dropbox\Operator.zip'
$destination = Join-Path $Env:Temp 'Operator'

Get-ChocolateyUnzip -PackageName 'Operator' -FileFullPath $font -Destination $destination

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
