local M = {}

function M.setup()
  -- if you want to debuf neovim
  -- 1. Open a Neovim instance (instance A)
  -- 2. Launch the DAP server with (A) > :lua require"osv".launch()
  -- 3. Open another Neovim instance (instance B)
  -- 4. Open `myscript.lua` (B)
  -- 5. Place a breakpoint on line 2 using (B) >
  -- :lua require"dap".toggle_breakpoint()
  -- 6. Connect the DAP client using (B) >
  -- :lua require"dap".continue()
  -- < Note: host - Press return, leave default
  -- port - Enter the port you wrote down
  -- 7. Run `myscript.lua` in the other instance (A) >
  -- :luafile myscript.lua
  -- 8. The breakpoint should hit and freeze the instance (B)
  local dap = require('dap')
  dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
  end
  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = 'Attach to running Neovim instance',
    },
  }
end

return M
