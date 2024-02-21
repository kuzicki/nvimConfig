local M = {
	"rohit-kumar-j/cmake-tools.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
	event = "VeryLazy",
}

function M.config()
	local wk = require "which-key"
	wk.register {
		["<leader>r"] = { "<cmd>CMakeRun<CR>", "Run CMake" },
	}

	require("cmake-tools").setup {
	cmake_command = "cmake", -- this is used to specify cmake command path
  ctest_command = "ctest", -- this is used to specify ctest command path
  cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  -- support macro expansion:
  --       ${kit}
  --       ${kitGenerator}
  --       ${variant:xx}
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },}
end

return M