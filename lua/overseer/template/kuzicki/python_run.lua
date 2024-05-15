return {
	name = "pymain",
	builder = function()

	local file = vim.fn.expand("%:p:h") .. "/main.py"
	return {
			cmd = {"python"},
			args = { file },
	}
	end,
	condition = {
		filetype = { "python" },
	},
}
