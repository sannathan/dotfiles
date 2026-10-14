# dotfiles
Meus dotfiles para configurar e personalizar meu ambiente de desenvolvimento. Inclui configurações para terminal, editor, shell e outros.

Gerenciado com [chezmoi](https://www.chezmoi.io/). Funciona em Windows e Linux.

## Máquina nova

### Windows
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
winget install --id twpayne.chezmoi -e
# reabra o terminal
chezmoi init --apply sannathan
```

### Linux
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply sannathan
```

## O que é configurado

| Item | Windows | Linux |
|---|---|---|
| Pacotes (winget) | `run_once_before_install-packages.ps1.tmpl` | - |
| Neovim (clonado de [sannathan/nvim](https://github.com/sannathan/nvim)) | `%LOCALAPPDATA%\nvim` | `~/.config/nvim` |
| PowerShell profile | `Documents\PowerShell\` | - |
| Windows Terminal (atalhos vim) | `AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\` | - |
| kitty / neofetch | - | `~/.config/` |

## Uso diário

```powershell
chezmoi edit --apply $PROFILE   # editar um arquivo gerenciado
chezmoi re-add                  # trazer para o repo mudanças feitas direto na máquina
chezmoi diff                    # ver o que vai mudar
chezmoi update                  # puxar do GitHub e aplicar
chezmoi git -- add -A; chezmoi git -- commit -m "..."; chezmoi git -- push
```

O nvim é um repo separado: edite em `%LOCALAPPDATA%\nvim` e faça commit/push nele.

### Atalhos do Windows Terminal

| Atalho | Ação |
|---|---|
| Alt+h / Alt+l | aba anterior / próxima |
| Alt+n | nova aba |
| Alt+q | fechar painel |
| Alt+Shift+h/j/k/l | foco entre painéis |
| Alt+v / Alt+s | split vertical / horizontal |
