return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter")
    config.setup({
      auto_install = true,
      ensure_installed = { "lua", "javascript", "typescript", "c" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
