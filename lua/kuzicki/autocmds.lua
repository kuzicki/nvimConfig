vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "cmake_tools_terminal",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
--   callback = function()
--     vim.cmd "quit"
--   end,
-- })

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd "checktime"
--   end,
-- })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 45 }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- TODO: fix
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   callback = function()
--     local status_ok, luasnip = pcall(require, "luasnip")
--     if not status_ok then
--       return
--     end
--     if luasnip.expand_or_jumpable() then
--       -- ask maintainer for option to make this silent
--       -- luasnip.unlink_current()
--       vim.cmd [[silent! lua require("luasnip").unlink_current()]]
--     end
--   end,
-- })


-- Remove ':' from indentkeys for C++ files
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cpp", "c", "h", "hpp", "cxx", "hxx"},
  callback = function()
    vim.opt_local.indentkeys:remove(":")
  end
})

local function CleanShaDaTmp()
  local shada_dir = vim.fn.stdpath("data") .. "/shada"
  local pattern = shada_dir .. "/main.shada.tmp.*"

  for _, file in ipairs(vim.fn.glob(pattern, false, true)) do
    -- protect against errors if file can't be deleted
    local ok, err = pcall(os.remove, file)
    if not ok then
      print("Failed to remove ShaDa temp file:", file, err)
    end
  end
end

-- Run on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = CleanShaDaTmp,
})
