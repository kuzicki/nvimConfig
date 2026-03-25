local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "clangd",
    "lua_ls",
    "pyright",
    "jsonls",
    "rust_analyzer",
    "omnisharp",
    "cmake",
    "ts_ls",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = {},
    automatic_installation = false,
    automatic_setup = false,
    automatic_enable = false,
    handlers = nil
  }
end

return M
