return {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
    vim.uv.cwd(),
  },
  settings = {
    python = {
      venvPath = vim.fn.expand "~" .. "/.virtualenvs",
    },
  },
}
