-- local M = {
--   "nvim-lualine/lualine.nvim",
--   dependencies = {
--     "AndreM222/copilot-lualine",
--     "nvim-tree/nvim-web-devicons"
--   },
-- }
--
-- function M.config()
--   require("lualine").setup {
--     options = {
--       component_separators = { left = "", right = "" },
--       section_separators = { left = "", right = "" },
--       ignore_focus = { "NvimTree" },
--     },
--     sections = {
--       lualine_a = {},
--       lualine_b = { "branch" },
--       lualine_c = { "diagnostics" },
--       lualine_x = { "copilot", "filetype" },
--       lualine_y = { "progress" },
--       lualine_z = {},
--     },
--     extensions = { "quickfix", "man", "fugitive" },
--   }
-- end
--
-- return M


local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
    "nvim-tree/nvim-web-devicons"
  },
}

function M.config()
local colors = {
  pinky = '#FF204E',
  dark_red = '#A0153E',
  dark_magenta = '#5D0E41',
  dark_blue = '#00224D',
  light_green = '#4793AF',
  lime = '#87A922',
  grayish = '#383a42',
  brown = '#8B322C'
}

local theme = {
  normal = {
  	a = { fg = colors.dark_magenta, bg = colors.pinky },
    b = { fg = colors.lime, bg = colors.dark_blue },
    c = { fg = colors.dark_magenta, bg = colors.dark_blue },
    z = { fg = colors.dark_blue, bg = colors.lime },
  },
    insert = { a = { fg = colors.dark_blue, bg = colors.light_green } },
    visual = { a = { fg = colors.dark_magenta, bg = colors.lime } },
    replace = { a = { fg = colors.dark_magenta, bg = colors.grayish } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = 'ok'
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.dark_red, bg = colors.dark_red } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
          comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
      return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
      return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local icons = require "kuzicki.icons"

local function modified()
  if vim.bo.modified then
      return icons.ui.Fire
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      return '-'
  end
  return ''
end

	require('lualine').setup {
  	options = {
  	  theme = theme,
    	component_separators = '',
    	section_separators = { left = '', right = '' },
  	},
    	sections = process_sections {
      	lualine_a = { 'mode' },
    		lualine_b = {
      		'branch',
      		'diff',
      		{
        		'diagnostics',
        		source = { 'nvim' },
        		sections = { 'error' },
        		diagnostics_color = { error = { bg = colors.dark_blue, fg = colors.pinky } },
      		},
      		{
        		'diagnostics',
        		source = { 'nvim' },
        		sections = { 'warn' },
        		diagnostics_color = { warn = { bg = colors.dark_blue, fg = colors.light_green } },
      		},
      		{ 'filename', file_status = false, path = 1 },
      		{ modified, color = { bg = colors.dark_blue } },
      		{
        		'%w',
        		cond = function()
          		return vim.wo.previewwindow
        		end,
      		},
      		{
        		'%r',
        		cond = function()
          		return vim.bo.readonly
        		end,
      		},
      		{
        		'%q',
        		cond = function()
          		return vim.bo.buftype == 'quickfix'
        		end,
      		},
    		},
    		lualine_c = {},
    		lualine_x = {},
    		lualine_y = { search_result, 'filetype' },
    		lualine_z = { '%l', '%p%%' },
  		},
    	inactive_sections = {
        	lualine_c = { '%f %y %m' },
    	lualine_x = {},
  	},
	}
end
return M
