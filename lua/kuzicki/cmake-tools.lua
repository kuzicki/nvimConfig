local M = {
  "rohit-kumar-j/cmake-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", },
  event = "VeryLazy",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>rm"] = { "<cmd>CMakeRun<CR>", "Run CMake" },
  }

  require("cmake-tools").setup {
    cmake_command = "cmake", -- this is used to specify cmake command path
    ctest_command = "ctest", -- this is used to specify ctest command path
    cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
    cmake_generate_options = { "-G \"MinGW Makefiles\"","-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-std=c++20" }, -- this will be passed when invoke `CMakeGenerate`
    cmake_build_options = {},
    -- cmake_build_directory = "out/${variant:buildType}",
    -- support macro expansion:
    --       ${kit}
    --       ${kitGenerator}
    --       ${variant:xx}
    -- cmake_executor = {
    --   name = "overseer",
    --   opts = {},
    --   default_opts = {
    --   	overseer = {
    --   		new_task_opts = {
    --   			strategy = {
    --   				"toggleterm",
    --   				direction = "float",
    --   				auto_scroll = true,
    --   				quit_on_success = "success"
    --   			}
    --   		}
    --   	}
    --   },
    -- },
    cmake_notifications = {
      runner = { enabled = true },
      executor = { enabled = true },
      spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
      refresh_rate_ms = 100, -- how often to iterate icons
    },
  }
end

return M
