local util = require "lspconfig/util"

return {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  root_dir = util.root_pattern("CMakeLists.txt", ".git"),
  settings = {
    cmake = {
      -- example setting, adjust if needed
      diagnostics = {
        enable = true,
      },
      -- more settings can be added here based on server docs
    }
  }
}
