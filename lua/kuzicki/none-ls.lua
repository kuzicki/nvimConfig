local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  }
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics =  null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      formatting.clang_format,
      formatting.djlint.with({
              args = { "--reformat", "-" }, -- Use reformatting via stdin
              filetypes = { "html", "jinja2" }, -- Add more if needed
          }),
      -- diagnostics.ruff,
      -- require("none-ls.diagnostics.flake8").with({extra_args = {"--max-line-length", "88", "--ignore", "F405,F403,E203,W503"}}),
      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      -- formatting.eslint,
      -- null_ls.builtins.diagnostics.flake8.with({extra_args = {"--max-line-length", "88", "--ignore", "F405,F403,E203"}}),
      null_ls.builtins.completion.spell,
    },
  }
end

return M
