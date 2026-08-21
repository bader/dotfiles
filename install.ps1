$ErrorActionPreference = "Stop"

$CONFIG = "install.conf.windows.yaml"
$DOTBOT_DIR = "dotbot"
$DOTBOT_BIN = "bin\dotbot"
$BASEDIR = $PSScriptRoot

Set-Location $BASEDIR
git submodule update --init --recursive

foreach ($PYTHON in ('python', 'python3')) {
    if (& { $ErrorActionPreference = "SilentlyContinue"
            ![string]::IsNullOrEmpty((&$PYTHON -V))
            $ErrorActionPreference = "Stop" }) {
        &$PYTHON $(Join-Path $BASEDIR -ChildPath $DOTBOT_DIR | Join-Path -ChildPath $DOTBOT_BIN) -d $BASEDIR -c $CONFIG $Args
        return
    }
}
Write-Error "Error: Cannot find Python. Install Python 3.8+ (e.g. 'winget install Python.Python.3') before running this script."
