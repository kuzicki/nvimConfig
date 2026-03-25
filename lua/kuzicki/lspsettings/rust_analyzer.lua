return {
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        autoreload = true,
        allFeatures = true,
      },
    },
  },
}
