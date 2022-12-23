local M = {}

function M.setup()
  local dap = require('dap')

  -- get command function
  local getCommand = function()
    if os.getenv('VIRTUAL_ENV') == nil then
      return '/Users/dengzhicheng/.pyenv/versions/3.9.1/envs/dev_env/bin/python'
    else
      return os.getenv('VIRTUAL_ENV') .. '/bin/python'
    end
  end

  dap.adapters.python = {
    type = 'executable',
    command = getCommand(),
    args = { '-m', 'debugpy.adapter' },
  }

  dap.configurations.python = {
    {
      type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch',
      name = 'Launch file',
      program = '${file}', -- This configuration will launch the current file if used.
      -- pythonPath = function()
      --   -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      --   -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      --   -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      --   local cwd = vim.fn.getcwd()
      --   if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
      --     return cwd .. '/venv/bin/python'
      --   elseif vim.fn.executable(cwd .. '.pyenv/shims/python') == 1 then
      --     return cwd .. '/.pyenv/shims/python'
      --   else
      --     return '/usr/bin/python'
      --   end
      -- end,
      pythonPath = '/Users/dengzhicheng/.pyenv/shims/python',
    },
  }
end

return M
