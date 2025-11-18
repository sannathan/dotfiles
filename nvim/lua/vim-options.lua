vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<leader>s", ":w<CR>", { noremap = true, silent = false, desc = "Delete File" })
vim.keymap.set("n", "<leader>w", ":q<CR>", { noremap = true, silent = false, desc = "Save File" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Mover para baixo, centralizar tela" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Mover para cima, centralizar tela" })
vim.keymap.set("n", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>q", ":qa<CR>", { noremap = true, silent = false, desc = "Quit all" })
