-- 基础设置
require('basic')
-- 快捷键绑定设置
require('keybindings')
-- Packer 插件管理
require('plugins')
-- 主题设置
require('colorscheme')
-- plugin's config
require('plugin-config.which-key')
require('plugin-config.nvim-tree')
require('plugin-config.bufferline')
require('plugin-config.lualine')
require('plugin-config.telescope')
require('plugin-config.dashboard')
require('plugin-config.project')
require('plugin-config.nvim-treesitter')
require('plugin-config.lspsaga')
-- lsp
require('lsp.setup')
require('lsp.cmp')
require('lsp.ui')
require('lsp.null-ls')
