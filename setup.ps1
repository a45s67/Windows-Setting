function install_wrap{
  param(
    $pkg,
    $src="winget"
  )
  winget list $pkg; (-not ($LASTEXITCODE -eq 0)) -and (winget install $pkg --source $src)
  
}

# do first: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned


# install choco
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#=======================================================

# install 1password
install_wrap -pkg  AgileBits.1Password
# install slack, microsoft teams, outlook
install_wrap -pkg SlackTechnologies.Slack 

install_wrap -pkg Microsoft.Teams


# install github
install_wrap -pkg  GitHub.cli
install_wrap -pkg  Git.Git
# install windows ternimal
install_wrap -pkg Microsoft.WindowsTerminal

# install powertoys
install_wrap -pkg Microsoft.PowerToys

# install powershell
install_wrap -pkg Microsoft.PowerShell

# install Fluent Search
# install_wrap -pkg 21814BlastApps.BlastSearch

# install 7z
winget install -e --id 7zip.7zip

#====================
# install vs2019

# install vcpkg

# install node
winget install -e --id OpenJS.NodeJS

#======================
# install vmware

# install win10 in vmware

# IDApro 7.5 , X96dbg, CFF explorer, PE bear

# process monitor, process explorer

#=======> nvim <=============

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# install nvim,python
choco install neovim -y
choco install python -y
choco install cascadia-code-nerd-font -y
choco install fzf -y
choco install ripgrep -y
refreshenv
# https://stackoverflow.com/questions/17794507/reload-the-path-in-powershell

# install vim plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
# install nvim module in python
py -m pip install pynvim

# install vim config for vscode from my github
git clone https://github.com/a45s67/nvim-note.git "$($env:localappdata)/nvim" 

#=======> termianl setting <=========
winget install JanDeDobbeleer.OhMyPosh
Install-Module posh-git -Scope CurrentUser
Install-Module PSReadLine -AllowPrerelease -Force
Install-Module -Name Terminal-Icons -Repository PSGallery

New-Item -Path $PROFILE -ItemType SymbolicLink -Value C:\Users\Fish\github\My-Windows-Setup\Microsoft.Powershell_Profile.ps1
New-Item -Path ~/PSReadLineProfile.ps1 -ItemType SymbolicLink -Value C:\Users\Fish\github\My-Windows-Setup\PSReadLineProfile.ps1 
# dont forget to install fonts (like nerd-font, cascadia code, firacode)


