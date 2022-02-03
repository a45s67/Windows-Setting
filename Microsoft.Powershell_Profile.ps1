$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
        ";" +
        [System.Environment]::GetEnvironmentVariable("Path","User")
Import-Module posh-git
oh-my-posh --init --shell pwsh --config C:\Users\Fish\github\oh-my-posh\themes\smoothie.omp.json | Invoke-Expression
Set-Alias -Name nv -Value nvim -Force
Invoke-Expression (& { (lua $HOME\github\z.lua\z.lua --init powershell) -join "`n" })
Import-Module -Name Terminal-Icons
. $HOME\PSReadLineProfile.ps1

function Unzip-Agent {
    param (
        $zip,
        $target="."
    )
    7z x -phealth $zip -o"$target"
    7z x -phealth "$target/*.zip" -o"$target"

}
# Set-Theme  Punk  # Emodipt , paradox , punk , sorin , ys 
