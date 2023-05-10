local status, dashboard = pcall(require, 'dashboard')
if not status then
  vim.notify('没有找到 dashboard')
  return
end

dashboard.setup({
  -- config
  theme = 'hyper',
  config = {
    --your header
    week_header = {
      enable = true,
    },
    packages = { enable = true },
    shortcut = {
      { desc = '󰊳 Update Packages', group = '@property', action = 'PackerSync', key = 'u' },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Find Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Files Tree',
        group = 'DiagnosticHint',
        action = 'NvimTreeToggle',
        key = 'b',
      },
      {
        desc = ' List Packages',
        group = 'Number',
        action = 'PackerStatus',
        key = 'l',
      },
    },
    footer = {
      '',
      ' 🚀 Sharp tools make good work.',
    }, --your footer
  },
})
