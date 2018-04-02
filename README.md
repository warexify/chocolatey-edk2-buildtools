# Chocolatey Packages

# Build

```posh
cd manual\PackageName
choco pack
```

# Debug

```posh
choco install package-id -fdvy -s .
```

# Publish

```
choco push package-id.1.1.0.nupkg -s https://push.chocolatey.org/
```
