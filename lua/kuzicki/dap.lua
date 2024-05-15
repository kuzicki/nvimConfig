local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio"
  },
}

function M.config()
  local dap = require "dap"
  local dapui = require "dapui"
  
  require("dapui").setup()
  require("dap-python").setup("C:/Users/TheBestComputer/AppData/Local/nvim-data/mason/packages/debugpy/venv/bin/python")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  vim.keymap.set("n", "<leader>jo", dap.toggle_breakpoint, {})
  vim.keymap.set("n", "<leader>jc", dap.continue, {})
end

return M
