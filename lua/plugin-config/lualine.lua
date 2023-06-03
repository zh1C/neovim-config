local status, lualine = pcall(require, 'lualine')
if not status then
  vim.notify('没有找到 lualine')
  return
end

lualine.setup({
  options = {
    theme = 'onedark',
    component_separators = { left = '|', right = '|' },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = ' ', right = '' },
  },
  extensions = { 'nvim-tree', 'toggleterm' },
  sections = {
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true,
        symbols = { added = ' ', modified = ' ', removed = ' ' },
      },
      -- 'diagnostics',
      -- use coc status included diagnostics
      '%{coc#status()}',
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        symbols = {
          modified = '[+]', -- Text to show when the file is modified.
          readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]', -- Text to show for new created file before first writting
        },
      },
      -- {
      --   'lsp_progress',
      --   spinner_symbols = { '󰇊', '󰇋', '󰇌', '󰇍', '󰇎', '󰇏' },
      -- },
      -- {
      --   -- Lsp server name .
      --   function()
      --     local msg = 'No Active Lsp'
      --     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      --     local clients = vim.lsp.get_active_clients()
      --     if next(clients) == nil then
      --       return msg
      --     end
      --     for _, client in ipairs(clients) do
      --       local filetypes = client.config.filetypes
      --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      --         return client.name
      --       end
      --     end
      --     return msg
      --   end,
      --   icon = ' LSP:',
      --   color = { fg = '#98be65', gui = 'bold' },
      -- },
    },
    lualine_x = {
      'filesize',
      {
        'fileformat',
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
      'encoding',
      'filetype',
    },
  },
})
