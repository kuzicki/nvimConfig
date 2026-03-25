return {
  cmd = { "C:\\Program Files\\OmniSharp\\OmniSharp.exe" },
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git", vim.uv.cwd() },
  settings = {
    omnisharp = {
      enableMsBuildLoadProjectsOnDemand = true,
    },
  },
}
