local status, db = pcall(require, 'dashboard')
if not status then
  vim.notify('没有找到 dashboard')
  return
end

db.custom_center = {
  {
    icon = '  ',
    desc = 'Projects                            ',
    shortcut = 'SPC p p',
    action = 'Telescope projects',
  },
  {
    icon = '  ',
    desc = 'Find files                          ',
    shortcut = 'SPC f f',
    action = 'Telescope oldfiles',
  },
  {
    icon = '  ',
    desc = 'Recently files                      ',
    shortcut = 'SPC f o',
    action = 'Telescope oldfiles',
  },
  {
    icon = '  ',
    desc = 'Edit keybindings                    ',
    shortcut = 'SPC f k',
    action = 'edit ~/.config/nvim/lua/keybindings.lua',
  },
}

db.custom_header = {
  '          ▀████▀▄▄              ▄█ ',
  '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
  '    ▄        █          ▀▀▀▀▄  ▄▀  ',
  '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
  '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
  '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
  '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
  '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
  '   █   █  █      ▄▄           ▄▀   ',
}
