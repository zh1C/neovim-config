-- https://github.com/lewis6991/gitsigns.nvim
local status, gitsigns = pcall(require, 'gitsigns')
if not status then
  vim.notify('没有找到 gitsigns')
  return
end

gitsigns.setup({
  -- 字母图标 A 增加，C修改，D 删除
  signs = {
    add = { text = 'A|' },
    change = { text = 'C|' },
    delete = { text = 'D_' },
    topdelete = { text = 'D‾' },
    changedelete = { text = 'D~' },
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    delay = 500,
  },
  on_attach = require('keybindings').gitsigns_on_attach,
})
