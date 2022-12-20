local M = {}

function M.setup()
  local dap = require('dap')
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
  dap.adapters.go = {
    type = 'server',
    -- If "${port}" nvim-dap resolves a free port.
    port = '${port}',
    executable = {
      command = 'dlv',
      -- ${port} used in the args is replaced with a dynamically resolved free port number
      args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
  }

  -- Neovim needs to instruct the debug adapter itself
  -- how to launch and connect to the debugee.
  -- The debugee is the application you want to debug.
  -- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L186
  dap.configurations.go = {
    -- debug launch for no args.
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      program = '${file}',
    },
  }
end

return M
