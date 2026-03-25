return {
  filetypes = { "json", "jsonc" },
  root_markers = { ".git", vim.uv.cwd() },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },
}
