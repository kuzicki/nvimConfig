local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<s-m>", "<cmd>lua require('kuzicki.harpoon').mark_file()<cr>", opts)
  keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
	keymap("n", "<C-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
	keymap("n", "<C-s>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
  keymap("n", "<C-n>", require('harpoon.ui').nav_next, opts)
  keymap("n", "<C-m>", require('harpoon.ui').nav_prev, opts)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "💵🐀🔫marked file 👍"
end

return M
