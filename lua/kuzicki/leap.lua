local M = {
	"ggandor/leap.nvim"
}

M.config = function()
	require("leap").create_default_mappings()
end

return M
