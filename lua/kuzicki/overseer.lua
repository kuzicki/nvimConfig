local M = {
		'stevearc/overseer.nvim',
		opts = {},
}

function M.config()
	local wk = require "which-key"
	wk.add {
		{ "<leader>rp", "<cmd>OverseerRun pymain<cr>", desc = "Run python main" },
		{ "<leader>rc", "<cmd>OverseerRun cmakerun<cr>", desc = "Run cmake" },
	}
	require("overseer").setup {
		strategy = {
			"toggleterm",
			quit_on_exit = "never",
			direction = "float",
		},
		templates = { "builtin", "kuzicki.python_run", "kuzicki.cmake_run"},
	}
end

return M
