return {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  root_markers = { "CMakeLists.txt", ".git", vim.uv.cwd() },
  settings = {
    cmake = {
      diagnostics = {
        enable = true,
      },
    },
  },
}
