local status, hop = pcall(require, 'hop')
if not status then
  vim.notify('没有找到 hop')
  return
end

hop.setup({
  -- configuration
  quit_key = '<SPC>',
  multi_windows = true,
  keys = 'etovxqpdygfblzhckisuran',
})
