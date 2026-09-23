# Documentação de Atalhos do Neovim

Este arquivo documenta os atalhos de teclado configurados para os plugins do Neovim. A tecla `<leader>` está configurada como a barra de espaço (` `).

## Atalhos Globais (`vim-options.lua`)

| Atalho      | Ação                                               |
|-------------|----------------------------------------------------|
| `<leader>w` | Salva o arquivo atual.                             |
| `<C-d>`     | Rola meia página para baixo e centraliza a tela.   |
| `<C-u>`     | Rola meia página para cima e centraliza a tela.    |
| `<leader>p` | Cola o conteúdo sem sobrescrever o que está na área de transferência. |

## Plugins

### Conform (`conform.lua`)

| Atalho      | Ação                  |
|-------------|-----------------------|
| `<leader>f` | Formata o buffer atual. |

### Completions (`completions.lua`)

| Atalho      | Ação                                    |
|-------------|-----------------------------------------|
| `<C-b>`     | Rola a documentação do item para cima.  |
| `<C-f>`     | Rola a documentação do item para baixo. |
| `<C-Space>` | Ativa ou completa o autocompletar.      |
| `<C-e>`     | Fecha a janela de autocompletar.        |
| `<CR>`      | Confirma a sugestão selecionada.        |

### LSP Config (`lsp-config.lua`)

| Atalho        | Ação                                                        |
|---------------|-------------------------------------------------------------|
| `K`           | Mostra informações sobre o símbolo sob o cursor (hover).    |
| `<leader>gd`  | Vai para a definição da função ou variável sob o cursor.    |
| `<leader>ca`  | Mostra as ações de código disponíveis (ex: refatoração).    |

### Neo-tree (`neo-tree-vim.lua`)

| Atalho  | Ação                                      |
|---------|-------------------------------------------|
| `<A-e>` | Abre/foca no explorador de arquivos à esquerda. |

### Telescope (`telescope.lua`)

| Atalho       | Ação                                            |
|--------------|-------------------------------------------------|
| `<leader>r`  | Procura arquivos no projeto.                    |
| `<leader>fg` | Procura por uma string em todos os arquivos (live grep). |
