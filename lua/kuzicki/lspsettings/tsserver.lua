local util = require "lspconfig/util"

return {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_dir = util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),

  settings = {
    typescript = {
      format = { enable = false },
    },
    javascript = {
      format = { enable = false },
    },
  },

  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if result.diagnostics then
        for _, diagnostic in ipairs(result.diagnostics) do
          if diagnostic.code == 6133 or diagnostic.code == 6196 then
            diagnostic.severity = 2
          end
        end
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
    end,
  },
}
