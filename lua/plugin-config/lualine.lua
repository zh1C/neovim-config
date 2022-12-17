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
      {
        'lsp_progress',
        spinner_symbols = { ' ', ' ', ' ', ' ', ' ', ' ' },
      },
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
