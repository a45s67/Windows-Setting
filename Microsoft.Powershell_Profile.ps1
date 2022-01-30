$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
        ";" +
        [System.Environment]::GetEnvironmentVariable("Path","User")
Import-Module posh-git
oh-my-posh --init --shell pwsh --config ~\.mytheme.omp.json | Invoke-Expression
Invoke-Expression (& { (lua C:\github\z.lua\z.lua --init powershell) -join "`n" })
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
