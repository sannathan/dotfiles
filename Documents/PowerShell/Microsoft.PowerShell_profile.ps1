# --- PSReadLine: autocomplete preditivo pelo histórico ---
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# --- Navegação ---
function pmr     { Set-Location 'C:\repos\pague-menos-logistica-avanade-code' }
function pmrepos { Set-Location 'C:\repos\pague-menos-logistica-avanade-code\src' }
function ..      { Set-Location .. }
function ...     { Set-Location ..\.. }

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# --- Git ---
# Remove aliases nativos que conflitam (gc = Get-Content, gl = Get-Location, gp = Get-ItemProperty)
foreach ($a in 'gc', 'gl', 'gp') { Remove-Item "Alias:$a" -Force -ErrorAction SilentlyContinue }
function gs { git status -sb @args }
function ga { git add @args }
function gc { git commit @args }
function gp { git push @args }
function gl { git --no-pager log --oneline --graph -20 @args }

# --- Editor ---
Set-Alias vim nvim
Set-Alias vi nvim
$env:EDITOR = 'nvim'
