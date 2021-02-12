# do first: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

# install winget
# (in my gmail) ms-windows-store://pdp/?productid=9nblggh4nns1

# set MSstore
$setting = @"
{
    // For documentation on these settings, see: https://aka.ms/winget-settings
    // "source": {
    //    "autoUpdateIntervalInMinutes": 5
    // },
    "visual": {
      "progressBar": "rainbow"
    },

    "experimentalFeatures": {
      "experimentalCmd": true,
      "experimentalArg": true,
      "experimentalMSStore": true,
      "list": true
    }
}
"@
# https://www.bleepingcomputer.com/news/microsoft/windows-10-package-manager-can-now-install-microsoft-store-apps/

$json = "$($env:localappdata)\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
Clear-Content -Path $json -Force
Add-Content -Path $json -Value $setting

# use oneget: 
# https://blog.miniasp.com/post/2016/02/19/Useful-tool-PackageManagement-OneGet


# install choco
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#=======================================================

# install 1password
winget install  AgileBits.1Password
# install slack, microsoft teams, outlook
winget install SlackTechnologies.Slack Microsoft.Teams


# install github
winget install  GitHub.cli
winget install  Git.Git
# install windows ternimal
winget install -s winget Microsoft.WindowsTerminal

# install powertoys
winget install Microsoft.PowerToys
# install Fluent Search
winget install 21814BlastApps.BlastSearch

#====================
# install vs2019

# install vcpkg

# install python
winget install Python.Python

#======================
# install vmware

# install win10 in vmware

# IDApro 7.5 , X96dbg, CFF explorer, PE bear

# process monitor, process explorer

#====================

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# install nvim,python
choco install neovim --version="0.5.0-beta"
choco install python

refreshenv
# https://stackoverflow.com/questions/17794507/reload-the-path-in-powershell

# install vim plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
# install nvim module in python
pip3 install neovim

# install vim config for vscode from my github
git clone https://github.com/a45s67/nvim.git "$($env:localappdata)/nvim"
