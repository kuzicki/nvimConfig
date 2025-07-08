local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- quickfix list keybinds
keymap("n", "<C-j>", ":cn<CR>", opts)
keymap("n", "<C-k>", ":cp<CR>", opts)

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>O", ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>", opts)
keymap("n", "<leader>o", ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr>", opts)

keymap("t", "<ESC>", "<C-\\><C-n>", opts)

keymap("n", "<C-i>", "<C-i>", opts)
keymap("n", "<C-P>", "<C-I>", opts)

vim.cmd("command Z w | qa")
vim.cmd("cabbrev wqa Z")

vim.cmd("cabbrev W w")


-- Better window navigation
keymap({"n", "x"}, "<m-h>", "<C-w>h", opts)
keymap({"n", "x"}, "<m-j>", "<C-w>j", opts)
keymap({"n", "x"}, "<m-k>", "<C-w>k", opts)
keymap({"n", "x"}, "<m-l>", "<C-w>l", opts)
keymap({"n", "x"}, "<m-tab>", "<c-6>", opts)
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("x", "p", [["_dP]])

vim.keymap.set("n", "<leader>cd", "<cmd>cd %/..<CR>", opts)

-- more good
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- tailwind bearable to work with(doesn't even know what it is)
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)

function _G.reload_nvim_conf()
  for name,_ in pairs(package.loaded) do
    if name:match('^kuzicki') or name:match('^lsp') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

local function map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts)
end
keymap('n', '<C-1>', '<cmd>lua reload_nvim_conf()<CR>')
