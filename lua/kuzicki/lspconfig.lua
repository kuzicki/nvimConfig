local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, opts)
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

function M.config()
  local wk = require "which-key"

  wk.add {
    { "<leader>l", group = "LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>", desc = "Format" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lh", "<cmd>lua require('kuzicki.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  }

  -- Setup capabilities with cmp_nvim_lsp (now that it's loaded)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  -- Global LSP config
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  local icons = require "kuzicki.icons"

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- Load lspconfig to register server definitions
  require "lspconfig"

  local servers = {
    clangd = {},
    lua_ls = {},
    pyright = {},
    jsonls = {},
    rust_analyzer = {},
    omnisharp = {},
    cmake = {},
    ts_ls = {},
  }

  for server, opts in pairs(servers) do
    local require_ok, settings = pcall(require, "kuzicki.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end

return M
