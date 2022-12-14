local status, toggleterm = pcall(require, 'toggleterm')
if not status then
  vim.notify('没有找到 toggleterm')
  return
end

toggleterm.setup({})

local Terminal = require('toggleterm.terminal').Terminal

-- custom float terminal
local ta = Terminal:new({
  direction = 'float',
  close_on_exit = true,
  float_opts = {
    border = 'double',
  },
})

-- custom horizontal terminal
local th = Terminal:new({
  direction = 'horizontal',
  close_on_exit = true,
})

local M = {}

M.toggleA = function()
  if ta:is_open() then
    ta:close()
    return
  end
  ta:open()
end

M.toggleH = function()
  if th:is_open() then
    th:close()
    return
  end
  th:open()
end

return M
