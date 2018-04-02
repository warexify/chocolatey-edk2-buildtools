Install-ChocolateyPackage 'nasm' 'exe' '/S' `
    'http://www.nasm.us/pub/nasm/releasebuilds/2.13.03/win32/nasm-2.13.03-installer-x86.exe' `
    'http://www.nasm.us/pub/nasm/releasebuilds/2.13.03/win64/nasm-2.13.03-installer-x64.exe' `
    -Checksum   'ef5991c04b762b5f8572c913c2810d6b67561944d4e91031fb7dc6fda455a335' -ChecksumType   'sha256' `
    -Checksum64 'c80a6dde9e5017f373ead8510fa1bd672cc1141ee93e617a85cca3a457902a43' -ChecksumType64 'sha256'
