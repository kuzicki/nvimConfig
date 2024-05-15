local M = {
  "LunarVim/darkplus.nvim",
  -- "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  -- vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "TabLineSelect", { bg = "none" })
  vim.cmd.colorscheme "darkplus"
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = "#FCE03D", bg = "#3187a3", bold = true, blend = 0})
  -- vim.api.nvim_set_hl(0, "MsgArea", { bg = "#3187a3" })
end

return M
