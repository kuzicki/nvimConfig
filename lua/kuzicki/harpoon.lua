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

  keymap("n", "<s-m>", "<cmd>lua require('kuzicki.harpoon').mark_file()<cr><cmd>lua require('kuzicki.harpoon').show_mark_list()<cr>", opts)
  keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr><cmd>lua require('kuzicki.harpoon').show_mark_list()<cr>", opts)
  keymap("n", "<C-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
  keymap("n", "<C-s>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
  vim.api.nvim_set_keymap("n", "<leader>ml", "<cmd>lua require('kuzicki.harpoon').show_mark_list()<CR>", { noremap = true, silent = true })
  keymap("n", "<C-n>", require('harpoon.ui').nav_next, opts)
  keymap("n", "<C-m>", require('harpoon.ui').nav_prev, opts)

  -- Automatically refresh the mark list every 60 seconds
  vim.defer_fn(function()
    M.show_mark_list()
    -- Call this function again in 60 seconds
    vim.defer_fn(M.config, 60000)
  end, 60000)
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "💵🐀🔫marked file 👍"
end

local mark_window = nil  -- Store the window handle
local mark_buf = nil     -- Store the buffer handle

-- Function to show or refresh the mark list
function M.show_mark_list()
    -- Get the list of marks using Harpoon's API
    local marks = {}
    for idx = 1, require('harpoon.mark').get_length() do
        local filename = require('harpoon.mark').get_marked_file_name(idx)
        if filename ~= "" then
            -- Truncate the filename to the last 20 characters
            filename = string.sub(filename, -30)
            table.insert(marks, filename)
        end
    end

-- If there are no marks, clear or destroy the window
    if #marks == 0 then
        if mark_window and vim.api.nvim_win_is_valid(mark_window) then
            vim.api.nvim_win_close(mark_window, true)  -- Close the window
            mark_window = nil
        end
        if mark_buf and vim.api.nvim_buf_is_valid(mark_buf) then
            vim.api.nvim_buf_delete(mark_buf, { force = true })  -- Delete the buffer
            mark_buf = nil
        end
        return
    end

    -- Close the existing window and buffer if they are open
    if mark_window and vim.api.nvim_win_is_valid(mark_window) then
        vim.api.nvim_win_close(mark_window, true)  -- Close the window
        vim.api.nvim_buf_delete(mark_buf, { force = true })  -- Delete the buffer
    end

    -- Create a new buffer and window
    mark_buf = vim.api.nvim_create_buf(false, true)  -- Create a new buffer
    vim.api.nvim_buf_set_lines(mark_buf, 0, -1, false, marks)  -- Set the lines in the buffer

    -- Set up the floating window
    local width = 30
    local height = #marks
    local row = 1
    local col = vim.o.columns - width - 1  -- Position at the top-right corner

    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
    }

    -- Open the floating window
    mark_window = vim.api.nvim_open_win(mark_buf, false, opts)
end

return M
