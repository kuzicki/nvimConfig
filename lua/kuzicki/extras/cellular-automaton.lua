local M = {
  "eandrju/cellular-automaton.nvim",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>yr"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Cellular Automaton: Make it rain" },
    ["<leader>yg"] = { "<cmd>CellularAutomaton game_of_life<CR>", "Cellular Automaton: Game of life" },
    ["<leader>ys"] = { "<cmd>CellularAutomaton scramble<CR>", "Cellular Automaton: Scramble" },
  }
end

return M
