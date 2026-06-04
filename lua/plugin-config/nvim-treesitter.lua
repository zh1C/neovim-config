local status, ts = pcall(require, 'nvim-treesitter')
if not status then
  vim.notify('没有找到 nvim-treesitter')
  return
end

-- main 分支：安装 parser（异步），不再有 ensure_installed 字段
ts.install({
  'go',
  'vim',
  'lua',
  'python',
  'bash',
  'c',
  'cpp',
  'markdown',
  'markdown_inline',
  'java',
  'json',
  'regex',
})

-- main 分支：高亮不再是模块，需在 FileType 时手动启用
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'go',
    'vim',
    'lua',
    'python',
    'sh',
    'bash',
    'c',
    'cpp',
    'markdown',
    'java',
    'json',
  },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
