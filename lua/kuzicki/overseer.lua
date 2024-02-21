local M = {
		'stevearc/overseer.nvim',
		opts = {},
}

function M.config() 
	require("overseer").setup {}
end

return M