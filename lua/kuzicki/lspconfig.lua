local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim", -- Replaces neodev.nvim (maintained & faster)
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  
  -- Updated to use vim.keymap.set (Clean, safer, modern API)
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

M.on_attach = function(client, bufnr)
  print("LSP ATTACHED to buffer: " .. bufnr)
  lsp_keymaps(bufnr)


  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

function M.common_capabilities()
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  
  -- If you use nvim-cmp, you usually want to add this line:
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  
  return capabilities
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Updated arguments for enable (boolean, filter)
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

function M.config()
  local wk = require "which-key"
  
  -- Kept wk.register for compatibility. 
  -- If you updated WhichKey to v3, you should use wk.add() instead.
  wk.register {
    ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    ["<leader>lf"] = {
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      "Format",
    },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
    ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    ["<leader>lh"] = { "<cmd>lua require('kuzicki.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
    ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  }

  wk.register {
    ["<leader>la"] = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
    },
  }

  local lspconfig = require "lspconfig"
  local icons = require "kuzicki.icons"

  local servers = {
    "clangd",
    "lua_ls",
    "pyright",
    "jsonls",
    "rust_analyzer",
    "omnisharp",
    "cmake",
    "ts_ls", -- Ensure this is ts_ls, not tsserver
  }

  -- Modern Diagnostic Config (Neovim 0.10+)
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

  -- Handling UI borders
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- The Setup Loop
  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "kuzicki.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    -- Fix: Removed manual neodev setup (lazydev handles this automatically now)

    -- Fix: Check if server exists in lspconfig before setup to avoid "index" errors
    if lspconfig[server] then
      lspconfig[server].setup(opts)
    end
  end
end

return M
