-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
-- 复用opt参数
local opt = { noremap = true, silent = true }

-- 退出insert mode, visual mode, command line到normal mode
map('i', 'jk', '<ESC>', opt)
map('v', 'jk', '<ESC>', opt)
map('c', 'jk', '<ESC>', opt)
-- 退出terminal mode 到normal mode
map('t', 'jk', '<C-\\><C-n>', opt)

-- 插入模式左右移动的快捷键
map('i', '<C-f>', '<Right>', opt)
map('i', '<C-b>', '<Left>', opt)

-- 重新绘制屏幕并暂时关闭高亮功能
map('n', '<C-l>', ':<C-u>nohlsearch<CR><C-l>', opt)
