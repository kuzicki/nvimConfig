return {
  cmd = { "C:\\Program Files\\OmniSharp\\OmniSharp.exe" },

  root_dir = function(fname)
    local root_file = vim.fs.find(function(name)
      return name:match("%.sln$") or name:match("%.csproj$")
    end, { path = fname, upward = true })[1]

    if root_file then
      return vim.fs.dirname(root_file)
    end

    return vim.fs.dirname(fname)
  end,

  settings = {
    omnisharp = {
      enableMsBuildLoadProjectsOnDemand = true,
    },
  },
}
