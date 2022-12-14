-- https://github.com/lewis6991/gitsigns.nvim
local status, gitsigns = pcall(require, 'gitsigns')
if not status then
  vim.notify('没有找到 gitsigns')
  return
end

gitsigns.setup({
  -- 字母图标 A 增加，C修改，D 删除
  signs = {
    add = { hl = 'GitSignsAdd', text = 'A|', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = 'C|', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = 'D_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = 'D‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = 'D~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    delay = 500,
  },
  word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
})
