-- 基础设置
require('basic')
-- 自定义设置
require('visual-star')

-- 基础快捷键设置
require('basic-keybindings')
-- Packer 插件管理
require('plugins')
-- which-key快捷键设置
require('keybindings')
-- 主题设置
require('colorscheme')

-- lsp
-- require('lsp.setup')
--
-- -- cmp
require('cmp.setup')

-- -- formatting and diagnostic
require('format.setup')

-- coc lsp cmp
require('coc.setup')

-- dap
require('dap.setup')
