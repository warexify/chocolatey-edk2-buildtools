import-module au

$releases = 'https://github.com/ninja-build/ninja/releases'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $url = $download_page.links | Where-Object href -match 'ninja-win.zip' | ForEach-Object href | Select-Object -First 1
    $version = (Split-Path ( Split-Path $url ) -Leaf).Substring(1)

    @{
        URL     = 'https://github.com' + $url
        Version = $version
    }
}

update
