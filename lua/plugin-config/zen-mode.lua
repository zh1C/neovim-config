local status, zen_mode = pcall(require, 'zen-mode')
if not status then
  vim.notify('没有找到 zen-mode')
  return
end

zen_mode.setup({})
