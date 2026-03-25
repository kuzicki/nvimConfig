local M = {
  "eandrju/cellular-automaton.nvim",
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>yr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Cellular Automaton: Make it rain" },
    { "<leader>yg", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Cellular Automaton: Game of life" },
    { "<leader>ys", "<cmd>CellularAutomaton scramble<CR>", desc = "Cellular Automaton: Scramble" },
  }
end

return M
