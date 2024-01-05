using namespace System.Management.Automation
using namespace System.Management.Automation.Language

New-Alias vim nvim
New-Alias vi nvim
New-Alias sudo gsudo
New-Alias which get-command
New-Alias touch ni
#New-Alias npm pnpm
New-Alias activate "./venv/Scripts/activate"
New-Alias spython "C:\Programming\Python\python.exe"
New-Alias spip "C:\Programming\Python\Scripts\pip.exe"

function symlink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function export { $env:Path += ';' + $args }
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

oh-my-posh prompt init pwsh --config C:\Users\SVick\Documents\Powershell\custom.json | Invoke-Expression


Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

$WarningPreference = "SilentlyContinue"

# Neovim Mode / Output is Redirected
if ([System.Console]::IsOutputRedirected){
    $PSStyle.OutputRendering = [OutputRendering]::PlainText;
} else {
    Import-Module -Name Terminal-Icons
    if ($host.Name -eq 'ConsoleHost') {
        Import-Module PSReadLine
    }
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
}

Set-PSReadLineOption -EditMode Windows
