local lspconfig = require("lspconfig")

return {
	cmd = { "C:\\Program Files\\OmniSharp\\OmniSharp.exe" },
	root_dir = function(fname)
		return lspconfig.util.root_pattern("*.sln", "*.csproj")(fname) or
			lspconfig.util.path.dirname(fname)
	end,
	on_attach = function(client, buffer)
		--Could configure the keymaps and other functionality
	end,
}
