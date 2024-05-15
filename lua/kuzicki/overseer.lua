local M = {
		'stevearc/overseer.nvim',
		opts = {},
}

function M.config()
	local wk = require "which-key"
	wk.register {
		["<leader>rp"] = { "<cmd>OverseerRun pymain<cr>", "Run python main"},
		["<leader>rc"] = { "<cmd>OverseerRun cmakerun<cr>", "Run cmake"}
	}
	require("overseer").setup {
		strategy = {
			"toggleterm",
			quit_on_exit = "never"
		},
		templates = { "builtin", "kuzicki.python_run", "kuzicki.cmake_run"},
	}
end

return M
