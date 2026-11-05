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
Set-PSReadLineOption -MaximumHistoryCount 10000
# Cores Catppuccin Mocha para a lista de sugestões e a linha de comando
Set-PSReadLineOption -Colors @{
  # Lista de sugestões do histórico (ListView)
  ListPrediction         = "`e[38;2;203;166;247m"   # Mauve: '>' e o [History]
  ListPredictionSelected = "`e[48;2;69;71;90m"      # fundo Surface1 no item selecionado
  ListPredictionTooltip  = "`e[38;2;127;132;156m"   # Overlay1: <History(10)>
  Emphasis               = "`e[1;38;2;243;139;168m" # Red negrito: trecho digitado que deu match
  InlinePrediction       = "`e[38;2;108;112;134m"   # Overlay0
  Default                = "`e[38;2;205;214;244m"   # Text
  Selection              = "`e[48;2;88;91;112m"     # Surface2
  Command                = "`e[38;2;137;180;250m"
  Parameter              = "`e[38;2;250;179;135m"
  String                 = "`e[38;2;166;227;161m"
  Operator               = "`e[38;2;148;226;213m"
  Variable               = "`e[38;2;245;194;231m"
  Comment                = "`e[38;2;108;112;134m"
}

# Ctrl+r: busca no histórico com fzf
function Invoke-FzfHistory {
  $line = Get-Content (Get-PSReadLineOption).HistorySavePath |
    Select-Object -Unique |
    fzf --tac --no-sort --height 40% --layout reverse --border rounded --prompt '❯ ' `
        --color 'bg+:#313244,fg+:#cdd6f4,hl:#f38ba8,hl+:#f38ba8,pointer:#f5e0dc,prompt:#cba6f7,border:#6c7086'
  if ($line) {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($line)
  }
}
if (Get-Command fzf -ErrorAction SilentlyContinue) {
  Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock { Invoke-FzfHistory }
}

# --- eza (ls moderno) ---
if (Get-Command eza -ErrorAction SilentlyContinue) {
  Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
  function ls { eza -a --icons --group-directories-first @args }
  function ll { eza -la --icons --git --group-directories-first --time-style relative @args }
  function la { eza -la --icons --git --group-directories-first @args }
  function lt { eza --tree --level 2 -a --icons --git-ignore --ignore-glob .git @args }
}

# --- Navegação ---
function pmr     { Set-Location 'C:\repos\pague-menos-logistica-avanade-code' }
function pmm     { cd 'C:\repos\pague-menos-logistica-avanade-code\src\app-distribuicao-cd' }
function pmrepos { Set-Location 'C:\repos\pague-menos-logistica-avanade-code\src' }
function pmb { Set-Location 'C:\repos\pague-menos-logistica-avanade-code\src\api-auditoria-deposito' }


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
