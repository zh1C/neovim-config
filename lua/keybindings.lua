-- set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
-- 复用opt参数
local opt = { noremap = true, silent = true }

-- 退出insert mode, visual mode, command line到normal mode
map('i', 'jk', '<ESC>', opt)
map('v', 'jk', '<ESC>', opt)
map('c', 'jk', '<ESC>', opt)
-- 退出terminal mode 到normal mode
map('t', 'jk', '<C-\\><C-n>', opt)

-- 插入模式左右移动的快捷键
map('i', '<C-f>', '<Right>', opt)
map('i', '<C-b>', '<Left>', opt)

-- nvim-tree 插件快捷键
local pluginKeys = {}
-- nvim-tree 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
  -- 分屏打开文件
  { key = 'v', action = 'vsplit' },
  { key = 'h', action = 'split' },
  -- 显示隐藏文件
  { key = '.', action = 'toggle_dotfiles' }, -- Hide (dotfiles)
  -- 文件操作
  { key = 'f', action = 'refresh' },
  { key = 'a', action = 'create' },
  { key = 'd', action = 'remove' },
  { key = 'r', action = 'rename' },
  { key = 'x', action = 'cut' },
  { key = 'c', action = 'copy' },
  { key = 'p', action = 'paste' },
  { key = 's', action = 'system_open' },
}

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ['<C-j>'] = 'move_selection_next',
    ['<C-k>'] = 'move_selection_previous',
    -- 历史记录
    ['<C-n>'] = 'cycle_history_next',
    ['<C-p>'] = 'cycle_history_prev',
    -- 关闭窗口
    ['<C-c>'] = 'close',
    -- 预览窗口上下滚动
    ['<C-u>'] = 'preview_scrolling_up',
    ['<C-d>'] = 'preview_scrolling_down',
  },
  n = {
    -- nomal mode 关闭窗口
    ['<C-c>'] = 'close',
  },
}
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  return {
    -- 出现补全
    ['<C-,>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- 取消
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- 上一个
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- 下一个
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- 确认
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果窗口内容太多，可以滚动
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- 自定义代码段跳转到下一个参数
    ['<C-l>'] = cmp.mapping(function(_)
      if vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      end
    end, { 'i', 's' }),

    -- 自定义代码段跳转到上一个参数
    ['<C-h>'] = cmp.mapping(function()
      if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),
  }
end

-- use which-key mapping
local status, wk = pcall(require, 'which-key')
if not status then
  vim.notify('没有找到 which-key')
  return
end

-- toggleterm
local termList = require('plugin-config.toggleterm')
wk.register({
  t = {
    name = 'Terminal',
    f = {
      function()
        termList.toggleA()
      end,
      'open/close float Terminal',
      mode = 'n',
      opt,
    },
    h = {
      function()
        termList.toggleH()
      end,
      'open/close horizontal Terminal',
      mode = 'n',
      opt,
    },
  },
}, { prefix = '<leader>' })

-- git shortcuts
wk.register({
  g = {
    name = 'git',
    g = {
      function()
        termList.toggleG()
      end,
      'open lazygit',
      mode = 'n',
      opt,
    },
  },
}, { prefix = '<leader>' })
-- gitsigns shortcuts
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local opts = { buffer = bufnr, mode = 'n', opt }

  wk.register({
    g = {
      name = 'git',
      v = { gs.preview_hunk, 'preview hunk', opts },
      n = { gs.next_hunk, 'next hunk', opts },
      p = { gs.prev_hunk, 'prev hunk', opts },
      r = { ':Gitsigns reset_hunk<CR>', 'reset hunk', opts },
    },
  }, { prefix = '<leader>' })
end

-- file shortcuts
wk.register({
  f = {
    name = 'Files',
    s = { ':w<CR>', 'Save', mode = 'n', opt },
    -- nvim-tree plugin
    t = { ':NvimTreeToggle<CR>', 'open/hiden file tree', mode = 'n', opt },
    f = { ':Telescope find_files<CR>', 'find file', mode = 'n', opt },
    o = { ':Telescope oldfiles<CR>', 'open recent file', mode = 'n', opt },
    k = { ':e ~/.config/nvim/lua/keybindings.lua<CR>', 'edit keybinding', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- quit shortcuts
wk.register({
  q = {
    name = 'quit',
    q = { ':q<CR>', 'quit neovim', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- windows shortcuts
wk.register({
  w = {
    name = 'windows',
    v = { ':vsp<CR>', 'split window right', mode = 'n', opt },
    s = { ':sp<CR>', 'split window below', mode = 'n', opt },
    d = { '<C-w>c', 'delete currrent window', mode = 'n', opt },
    o = { '<C-w>o', 'delete other windows', mode = 'n', opt },
    l = { '<C-w>l', 'go to the right window', mode = 'n', opt },
    h = { '<C-w>h', 'go to the left window', mode = 'n', opt },
    j = { '<C-w>j', 'go to the down window', mode = 'n', opt },
    k = { '<C-w>k', 'go to the up window', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- buffer line shortcuts
wk.register({
  b = {
    name = 'buffers',
    c = { ':BufferLinePickClose<CR>', 'Choose buffer close', mode = 'n', opt },
    p = { ':BufferLineCyclePrev<CR>', 'Previous buffer', mode = 'n', opt },
    n = { ':BufferLineCycleNext<CR>', 'Next buffer', mode = 'n', opt },
    d = { ':Bdelete!<CR>', 'Kill buffer', mode = 'n', opt },
    b = { ':Telescope buffers<CR>', 'List buffers', mode = 'n', opt },
    ['1'] = { ':BufferLineGoToBuffer 1<CR>', 'Go to buffer 1', mode = 'n', opt },
    ['2'] = { ':BufferLineGoToBuffer 2<CR>', 'Go to buffer 2', mode = 'n', opt },
    ['3'] = { ':BufferLineGoToBuffer 3<CR>', 'Go to buffer 3', mode = 'n', opt },
    ['4'] = { ':BufferLineGoToBuffer 4<CR>', 'Go to buffer 4', mode = 'n', opt },
    ['5'] = { ':BufferLineGoToBuffer 5<CR>', 'Go to buffer 5', mode = 'n', opt },
    ['6'] = { ':BufferLineGoToBuffer 6<CR>', 'Go to buffer 6', mode = 'n', opt },
    ['7'] = { ':BufferLineGoToBuffer 7<CR>', 'Go to buffer 7', mode = 'n', opt },
    ['8'] = { ':BufferLineGoToBuffer 8<CR>', 'Go to buffer 8', mode = 'n', opt },
    ['9'] = { ':BufferLineGoToBuffer 9<CR>', 'Go to buffer 9', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- search shortcuts
wk.register({
  s = {
    name = 'search',
    s = { ':Telescope current_buffer_fuzzy_find<CR>', 'search current buffer', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- project shortcuts
wk.register({
  p = {
    name = 'project',
    p = { ':Telescope projects<CR>', 'open project', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- install shortcuts
wk.register({
  i = {
    name = 'install/info',
    p = { ':TSInstallInfo<CR>', 'language parser info', mode = 'n', opt },
    m = { ':Mason<CR>', 'mason lsp', mode = 'n', opt },
    n = { ':NullLsInfo<CR>', 'null-ls info', mode = 'n', opt },
    l = { ':LspInfo<CR>', 'language server info', mode = 'n', opt },
    s = { ':PackerSync<CR>', 'update and compile plugins', mode = 'n', opt },
    u = { ':PackerUpdate<CR>', 'update and install plugins', mode = 'n', opt },
    c = { ':PackerCompile<CR>', 'compile plugins configuration', mode = 'n', opt },
    w = { ':PackerStatus<CR>', 'show list of installed plugins', mode = 'n', opt },
    r = { ':PackerClean<CR>', 'Remove disabled or unused plugins', mode = 'n', opt },
  },
}, { prefix = '<leader>' })

-- comment shortcuts
-- setting in file ./plugin-config/comment.lua
wk.register({
  c = {
    name = 'comments',
  },
}, { prefix = '<leader>' })

-- surround shortcuts
-- setting in file ./plugin-config/surround.lua
wk.register({
  o = {
    name = 'surround',
  },
}, { prefix = '<leader>' })

-- jump hop shortcuts
local hop = require('hop')
wk.register({
  j = {
    name = 'jump',
    l = {
      function()
        hop.hint_lines()
      end,
      'line',
      mode = 'n',
      opt,
    },
    c = {
      function()
        hop.hint_char2()
      end,
      'char2',
      mode = 'n',
      opt,
    },
    j = {
      function()
        hop.hint_char1({ current_line_only = true })
      end,
      'char current line',
      mode = 'n',
      opt,
    },
    p = {
      function()
        hop.hint_patterns()
      end,
      'patterns',
      mode = 'n',
      opt,
    },
    w = {
      function()
        hop.hint_words()
      end,
      'words',
      mode = 'n',
      opt,
    },
  },
}, { prefix = '<leader>' })

-- lsp 回调函数快捷键设置,use which-key plugin
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- mapbuf("r", "<cmd>lua vim.lsp.buf.rename()<CR>", "rename", "n")
  mapbuf('r', ':Lspsaga rename<CR>', 'rename', 'n')

  -- code action Lspsaga替换
  -- mapbuf("a", "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action", "n")
  mapbuf('a', ':Lspsaga code_action<CR>', 'code action', 'n')

  -- Peek Definition
  -- -- you can edit the definition file in this floatwindow
  -- -- also support open/vsplit/etc operation check definition_action_keys
  -- -- support tagstack C-t jump back
  mapbuf('p', ':Lspsaga peek_definition<CR>', 'peek definition', 'n')

  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  mapbuf('f', ':Lspsaga lsp_finder<CR>', 'lsp finder', 'n')

  mapbuf('d', '<cmd>lua vim.lsp.buf.definition()<CR>', 'go definition', 'n')
  mapbuf('i', '<cmd>lua vim.lsp.buf.implementation()<CR>', 'go implementation', 'n')
  mapbuf('e', '<cmd>lua vim.lsp.buf.refereances()<CR>', 'go refereances', 'n')
  mapbuf('D', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'go declaration', 'n')
  -- mapbuf("h", "<cmd>lua vim.lsp.buf.hover()<CR>", "hover doc", "n")
  mapbuf('h', ':Lspsaga hover_doc<CR>', 'hover doc', 'n')

  -- diagnostic
  -- mapbuf("p", "<cmd>lua vim.diagnostic.open_float()<CR>", "open float", "n")
  mapbuf('s', ':Lspsaga show_line_diagnostics<CR>', 'show line diagnostic', 'n')
  -- Diagnostic jump can use `<c-o>` to jump back
  -- mapbuf("k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "goto prev", "n")
  mapbuf('k', ':Lspsaga diagnostic_jump_prev<CR>', 'diagnostic jump prev', 'n')
  -- mapbuf("j", "<cmd>lua vim.diagnostic.goto_next()<CR>", "goto next", "n")
  mapbuf('j', ':Lspsaga diagnostic_jump_next<CR>', 'diagnostic jump next', 'n')

  mapbuf('=', ': lua vim.lsp.buf.format({ bufnr = bufnr })<CR>', 'formatting', 'n')
  -- code action
  -- 没用到
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- 返回nvim-tree 的快捷键列表
return pluginKeys
