function install_wrap{
  param(
    $pkg,
    $src="winget"
  )
  winget list $pkg; (-not ($LASTEXITCODE -eq 0)) -and (winget install $pkg --source $src)
  
}

# do first: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

# install winget
# (in my gmail) ms-windows-store://pdp/?productid=9nblggh4nns1
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v-0.2.10191-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -outfile winget.appxbundle
Add-AppxPackage -Path "winget.appxbundle"

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
install_wrap -pkg  AgileBits.1Password
# install slack, microsoft teams, outlook
install_wrap -pkg SlackTechnologies.Slack Microsoft.Teams


# install github
install_wrap -pkg  GitHub.cli
install_wrap -pkg  Git.Git
# install windows ternimal
install_wrap -pkg Microsoft.WindowsTerminal

# install powertoys
install_wrap -pkg Microsoft.PowerToys

# install powershell
install_wrap -pkg --id Microsoft.PowerShell

# install Fluent Search
# install_wrap -pkg 21814BlastApps.BlastSearch

#====================
# install vs2019

# install vcpkg

# install python
install_wrap -pkg Python.Python

#======================
# install vmware

# install win10 in vmware

# IDApro 7.5 , X96dbg, CFF explorer, PE bear

# process monitor, process explorer

#=======> nvim <=============

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# install nvim,python
choco install neovim --version="0.5.0-beta"
choco install python
choco install cascadia-code-nerd-font
refreshenv
# https://stackoverflow.com/questions/17794507/reload-the-path-in-powershell

# install vim plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
# install nvim module in python
pip3 install neovim

# install vim config for vscode from my github
git clone https://github.com/a45s67/nvim.git "$($env:localappdata)/nvim" -or
git -C "$($env:localappdata)/nvim" pull

# copy settings
Copy-Item "$($env:localappdata)\nvim\utils\vscode_config\*" "$($env:appdata)\code\User"

#=======> termianl setting <=========
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Update-Module -Name oh-my-posh -AllowPrerelease -Scope CurrentUser

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }

$theme_startup = @'
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt pure
# Set-Theme  Punk  # Emodipt , paradox , punk , sorin , ys 
'@
Add-Content -Path $PROFILE -Value  $theme_startup
# dont forget to install fonts (like nerd-font, cascadia code, firacode)


