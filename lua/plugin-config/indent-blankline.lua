local status, indent_blankline = pcall(require, 'indent_blankline')
if not status then
  vim.notify('没有找到 indent_blankline')
  return
end

indent_blankline.setup({
  show_end_of_line = true,
})
