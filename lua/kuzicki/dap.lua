local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
		"nvim-neotest/nvim-nio"
  },
}

local last_executable_path = nil

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
  vim.keymap.set("n", "<leader>jr", dap.run_last, {})
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe",
      args = { "--port", "${port}" },
    }
  }

  dap.configurations.rust = {
    {
      name = "Debug Rust",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    }
  }

  dap.configurations.cpp = {
    {
      name = "Launch C++ file",
      type = "codelldb",
      request = "launch",
      program = function()
        if not last_executable_path then
          last_executable_path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end
        return last_executable_path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    }
  }
end

vim.keymap.set("n", "<leader>jx", function()
  last_executable_path = nil
  print("Executable path reset!")
end)

return M
