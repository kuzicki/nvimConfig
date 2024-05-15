local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ignore_install = {},
    sync_install = false,
    auto_install = true,
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "c", "vimdoc"},
    highlight = { enable = true },
    indent = { enable = true },
    modules = {}
  }
end

return M
