function prompt {
    # 1. Pega o caminho atual e encurta a pasta principal para "~"
    $path = (Get-Location).Path -replace "^$([Regex]::Escape($env:USERPROFILE))", "~"

    # 2. Define as cores exatas do Catppuccin Mocha usando ANSI RGB
    $cReset   = "`e[0m"
    $cGray    = "`e[38;2;108;112;134m"   # Overlay0 (Bordas)
    $cBlue    = "`e[38;2;137;180;250m"   # Blue (Ícones)
    $cCyan    = "`e[38;2;148;226;213m"   # Teal (Caminho)
    $cMagenta = "`e[38;2;245;194;231m"   # Pink (Seta 1)
    $cRed     = "`e[38;2;243;139;168m"   # Red (Admin)

    # 3. Ícones da Nerd Font
    $iconFolder = ""
    $iconPrompt = "❯"
    
    # 4. Monta a Linha de Cima (Caminho e Informações)
    $line1 = "`n$cGray╭─ $adminStr$cBlue$iconFolder $cCyan$path$cReset"
    
    # 6. Monta a Linha de Baixo (Local de digitação com setas em degradê)
    $line2 = "`n$cGray╰─$cMagenta $iconPrompt$cBlue $iconPrompt$cCyan $iconPrompt$cReset"

    # Retorna o visual final
    return "$line1$line2"
}

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
function pmm     { cd 'C:\repos\pague-menos-logistica-avanade-code\src\app-distribuicao-cd' }
function pmrepos { Set-Location 'C:\repos\pague-menos-logistica-avanade-code\src' }


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
