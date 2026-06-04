local status, surround = pcall(require, 'nvim-surround')
if not status then
  vim.notify('没有找到 nvim-surround')
  return
end

-- v4: keymaps are no longer configurable through setup(); set them via <Plug> mappings.
surround.setup({})

local map = vim.keymap.set
map('i', '<C-g>s', '<Plug>(nvim-surround-insert)', { desc = 'Surround: insert' })
map('i', '<C-g>S', '<Plug>(nvim-surround-insert-line)', { desc = 'Surround: insert line' })
map('n', '<leader>os', '<Plug>(nvim-surround-normal)', { desc = 'Surround: normal' })
map('n', '<leader>oss', '<Plug>(nvim-surround-normal-cur)', { desc = 'Surround: normal cur' })
map('n', '<leader>oS', '<Plug>(nvim-surround-normal-line)', { desc = 'Surround: normal line' })
map('n', '<leader>oSS', '<Plug>(nvim-surround-normal-cur-line)', { desc = 'Surround: normal cur line' })
map('x', 'S', '<Plug>(nvim-surround-visual)', { desc = 'Surround: visual' })
map('x', 'gS', '<Plug>(nvim-surround-visual-line)', { desc = 'Surround: visual line' })
map('n', '<leader>od', '<Plug>(nvim-surround-delete)', { desc = 'Surround: delete' })
map('n', '<leader>oc', '<Plug>(nvim-surround-change)', { desc = 'Surround: change' })
