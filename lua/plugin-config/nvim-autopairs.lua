-- https://github.com/windwp/nvim-autopairs
local status, autopairs = pcall(require, 'nvim-autopairs')
if not status then
  vim.notify('没有找到 nvim-autopairs')
  return
end

autopairs.setup({
  -- When run :verbose imap <cr>,
  -- It will return v:lua.MPairs.completion_confirm().
  -- It can finish below:
  -- Before        Input         After
  -- ------------------------------------
  -- {|}           <CR>          {
  --                                 |
  --                             }
  -- ------------------------------------
  -- But we need <cr> to accept selected completion item,
  -- so we need set map_cr = false,
  map_cr = false,
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
  },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- <cr> conflict
-- https://github.com/windwp/nvim-autopairs/wiki/Completion-plugin
local remap = vim.api.nvim_set_keymap
-- skip it, if you use another global object
_G.MUtils = {}

-- new version for custom pum
MUtils.completion_confirm = function()
  if vim.fn['coc#pum#visible']() ~= 0 then
    return vim.fn['coc#pum#confirm']()
  else
    return autopairs.autopairs_cr()
  end
end

remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { silent = true, expr = true, noremap = true })
