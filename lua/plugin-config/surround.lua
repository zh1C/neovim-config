local status, surround = pcall(require, 'nvim-surround')
if not status then
  vim.notify('没有找到 nvim-surround')
  return
end

surround.setup({
  -- configuration
  keymaps = {
    insert = '<C-g>s',
    insert_line = '<C-g>S',
    normal = '<leader>os',
    normal_cur = '<leader>oss',
    normal_line = '<leader>oS',
    normal_cur_line = '<leader>oSS',
    visual = 'S',
    visual_line = 'gS',
    delete = '<leader>od',
    change = '<leader>oc',
  },
})
