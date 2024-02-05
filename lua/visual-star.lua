-- 修改visual mode下 * #按键的行为
-- * 正向查找选中文本
-- # 反向查找选中文件
vim.api.nvim_set_keymap('x', '*', ':<C-u>lua VSetSearch("/")<CR>/<C-R>=@/<CR><CR>', { noremap = true })
vim.api.nvim_set_keymap('x', '#', ':<C-u>lua VSetSearch("?")<CR>?<C-R>=@/<CR><CR>', { noremap = true })
-- <C-u> 插入模式和命令模式下,删除当前光标到行首的所有内容
-- <C-R>=@/ 表示插入搜索寄存器的内容

function VSetSearch(cmdtype)
  -- 获取寄存器s的内容
  local temp = vim.fn.getreg('s')

  -- 执行普通模式的命令gv"sy
  -- gv 表示重新选择上次visual mode的内容
  vim.cmd('normal! gv"sy')
  -- 设置搜索寄存器/的内容
  vim.fn.setreg(
    '/',
    '\\V' .. vim.fn.substitute(vim.fn.escape(vim.fn.getreg('s'), cmdtype .. '\\'), '\\n', '\\\\n', 'g')
  )
  vim.fn.setreg('s', temp)
end
