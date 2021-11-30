Import-Module posh-git
oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\emodipt.omp.json | Invoke-Expression
Invoke-Expression (& { (lua C:\github\z.lua --init powershell) -join "`n" })
# Import-Module oh-my-posh
# Set-PoshPrompt pure

function Unzip-Agent {
    param (
        $zip,
        $target="."
    )
    7z x -phealth $zip -o"$target"
    7z x -phealth "$target/*.zip" -o"$target"

}
# Set-Theme  Punk  # Emodipt , paradox , punk , sorin , ys 
