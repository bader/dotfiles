$ErrorActionPreference = "Stop"

if (Get-Command nvim -ErrorAction SilentlyContinue) {
    exit 0
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget is required to install Neovim automatically."
}

winget install --id Neovim.Neovim --exact --accept-package-agreements --accept-source-agreements
