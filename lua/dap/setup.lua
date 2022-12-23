local status, dap = pcall(require, 'dap')
if not status then
  vim.notify('没有找到 dap')
  return
end

local statu, dapui = pcall(require, 'dapui')
if not statu then
  vim.notify('没有找到 dapui')
  return
end

-- dap ui
require('dap.dap-ui')

dapui.setup({
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
})

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close({})
end

-- golang dap config
require('dap.config.dap-go').setup()

-- python dap config
require('dap.config.dap-python').setup()

-- lua dap config
require('dap.config.dap-lua').setup()

-- keymapping
require('keybindings').mapDAP()
