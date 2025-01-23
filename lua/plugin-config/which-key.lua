local status, which_key = pcall(require, 'which-key')
if not status then
  vim.notify('没有找到 which-key')
  return
end

-- 配置 which-key
-- 可以配置请参考 https://github.com/folke/which-key.nvim
which_key.setup({
  preset = 'modern',
  -- leave it empty to use the default settings.
  replace = {
    key = {
      { '<leader>', 'SPC' },
    },
  },
  plugins = {
    presets = {
      motions = false,
    },
  },
  triggers = {
    { '<auto>', mode = 'nso' },
  },
})
