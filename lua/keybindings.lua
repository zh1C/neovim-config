-- use which-key mapping
local status, wk = pcall(require, 'which-key')
if not status then
  vim.notify('没有找到 which-key')
  return
end

------------- coc shortcut keys--------------------
local keyset = vim.keymap.set

-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use <C-j> for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <C-j>' to make sure <C-j> is not mapped by
-- other plugins before putting this into your config
local opts1 = { silent = true, noremap = true, expr = true, replace_keycodes = false }
-- keyset('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts1)
keyset('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : coc#refresh()', opts1)
keyset('i', '<C-k>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts1)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
-- keyset('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts1)
-- Because <cr> conflict nvim-autopair plugin autopairs_cr(),
-- this shortcut key setting is plugins-config/nvim-autopairs.lua

-- Use `[g` and `]g` to navigate diagnostics
-- -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
keyset('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })
--
-- -- GoTo code navigation
keyset('n', 'gd', '<Plug>(coc-definition)', { silent = true })
keyset('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
keyset('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
keyset('n', 'gr', '<Plug>(coc-references)', { silent = true })

------ coc multiple cursor

wk.add({
  { '<leader>m', group = 'multiple corsur' },
  { '<leader>mc', '<Plug>(coc-cursors-position)', desc = 'add current character range to cursors' },
  { '<leader>mo', '<plug>(coc-cursors-operator)', desc = 'use operator for add range to cursors' },
  { '<leader>mw', '<plug>(coc-cursors-word)', desc = 'add current word range to cursors' },
  { '<leader>mr', '<plug>(coc-cursors-range)', desc = 'add current visual selected range to cursors', mode = 'v' },
})

-- Use <leader>h to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

wk.add({
  { '<leader>h', '<cmd>lua _G.show_docs()<CR>', desc = 'Show doc' },
})

-- Symbol renaming
wk.add({
  { '<leader>r', '<Plug>(coc-rename)', desc = 'Symbol rename' },
})

-------------- end coc shortcut keys ---------------

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
    -- ['<CR>'] = cmp.mapping.confirm({
    --   select = false,
    --   behavior = cmp.ConfirmBehavior.Replace,
    -- }),
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

-- toggleterm
local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
})

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

local termList = {}

termList.toggleA = function()
  if ta:is_open() then
    ta:close()
    return
  end
  ta:open()
end

termList.toggleH = function()
  if th:is_open() then
    th:close()
    return
  end
  th:open()
end

termList.toggleG = function()
  lazygit:toggle()
end

wk.add({
  { '<leader>t', group = 'Terminal' },
  {
    '<leader>tf',
    function()
      termList.toggleA()
    end,
    desc = 'open/close float Terminal',
  },
  {
    '<leader>th',
    function()
      termList.toggleH()
    end,
    desc = 'open/close horizontal Terminal',
  },
})

-- git shortcuts
wk.add({
  { '<leader>g', group = 'git' },
  {
    '<leader>gg',
    function()
      termList.toggleG()
    end,
    desc = 'open lazygit',
  },
})

-- gitsigns shortcuts
pluginKeys.gitsigns_on_attach = function()
  local gs = package.loaded.gitsigns

  wk.add({
    { '<leader>g', group = 'git' },
    { '<leader>gn', gs.next_hunk, desc = 'next hunk' },
    { '<leader>gp', gs.prev_hunk, desc = 'prev hunk' },
    { '<leader>gr', ':Gitsigns reset_hunk<CR>', desc = 'reset hunk' },
    { '<leader>gv', gs.preview_hunk, desc = 'preview hunk' },
  })
end

-- file shortcuts
wk.add({
  { '<leader>f', group = 'Files' },
  { '<leader>ff', ':Telescope find_files<CR>', desc = 'find file' },
  { '<leader>fk', ':e ~/.config/nvim/lua/keybindings.lua<CR>', desc = 'edit keybinding' },
  { '<leader>fo', ':Telescope oldfiles<CR>', desc = 'open recent file' },
  { '<leader>fs', ':w<CR>', desc = 'Save' },
  { '<leader>ft', ':NvimTreeToggle<CR>', desc = 'open/hiden file tree' },
})

-- quit shortcuts
wk.add({
  { '<leader>q', group = 'quit' },
  { '<leader>qq', ':q<CR>', desc = 'quit neovim' },
})

-- windows shortcuts
wk.add({
  { '<leader>w', group = 'windows' },
  { '<leader>wd', '<C-w>c', desc = 'delete currrent window' },
  { '<leader>wh', '<C-w>h', desc = 'go to the left window' },
  { '<leader>wj', '<C-w>j', desc = 'go to the down window' },
  { '<leader>wk', '<C-w>k', desc = 'go to the up window' },
  { '<leader>wl', '<C-w>l', desc = 'go to the right window' },
  { '<leader>wo', '<C-w>o', desc = 'delete other windows' },
  { '<leader>ws', ':sp<CR>', desc = 'split window below' },
  { '<leader>wv', ':vsp<CR>', desc = 'split window right' },
})

-- buffer line shortcuts
wk.add({
  { '<leader>b', group = 'buffers' },
  { '<leader>b1', ':BufferLineGoToBuffer 1<CR>', desc = 'Go to buffer 1' },
  { '<leader>b2', ':BufferLineGoToBuffer 2<CR>', desc = 'Go to buffer 2' },
  { '<leader>b3', ':BufferLineGoToBuffer 3<CR>', desc = 'Go to buffer 3' },
  { '<leader>b4', ':BufferLineGoToBuffer 4<CR>', desc = 'Go to buffer 4' },
  { '<leader>b5', ':BufferLineGoToBuffer 5<CR>', desc = 'Go to buffer 5' },
  { '<leader>b6', ':BufferLineGoToBuffer 6<CR>', desc = 'Go to buffer 6' },
  { '<leader>b7', ':BufferLineGoToBuffer 7<CR>', desc = 'Go to buffer 7' },
  { '<leader>b8', ':BufferLineGoToBuffer 8<CR>', desc = 'Go to buffer 8' },
  { '<leader>b9', ':BufferLineGoToBuffer 9<CR>', desc = 'Go to buffer 9' },
  { '<leader>bb', ':Telescope buffers<CR>', desc = 'List buffers' },
  { '<leader>bc', ':BufferLinePickClose<CR>', desc = 'Choose buffer close' },
  { '<leader>bd', ':Bdelete!<CR>', desc = 'Kill buffer' },
  { '<leader>bn', ':BufferLineCycleNext<CR>', desc = 'Next buffer' },
  { '<leader>bp', ':BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
})

-- search shortcuts
wk.add({
  { '<leader>s', group = 'search' },
  { '<leader>sd', ':CocDiagnostics<CR>', desc = 'show diagnostics in window' },
  { '<leader>se', ':Telescope diagnostics<CR>', desc = 'search diagnostics' },
  { '<leader>ss', ':Telescope current_buffer_fuzzy_find<CR>', desc = 'search current buffer' },
})

-- project shortcuts
wk.add({
  { '<leader>p', group = 'project' },
  { '<leader>pp', ':Telescope projects<CR>', desc = 'open project' },
})

-- zen-mode
wk.add({
  { '<leader>z', ':ZenMode<CR>', desc = 'open/close Zen-Mode' },
})

-- install shortcuts
wk.add({
  { '<leader>i', group = 'install/info' },
  { '<leader>il', ':LspInfo<CR>', desc = 'language server info' },
  { '<leader>im', ':Mason<CR>', desc = 'mason lsp' },
  { '<leader>in', ':NullLsInfo<CR>', desc = 'null-ls info' },
  { '<leader>ip', ':TSInstallInfo<CR>', desc = 'language parser info' },
  { '<leader>iu', ':Lazy<CR>', desc = 'Open Lazy' },
})

-- comment shortcuts
-- setting in file ./plugin-config/comment.lua
wk.add({
  { '<leader>c', group = 'comments' },
})

-- surround shortcuts
-- setting in file ./plugin-config/surround.lua
wk.add({
  { '<leader>o', group = 'surround' },
})

-- jump hop shortcuts
local hop = require('hop')
wk.add({
  { '<leader>j', group = 'jump' },
  {
    '<leader>jc',
    function()
      hop.hint_char2()
    end,
    desc = 'char2',
  },
  {
    '<leader>jj',
    function()
      hop.hint_char1({ current_line_only = true })
    end,
    desc = 'char current line',
  },
  {
    '<leader>jl',
    function()
      hop.hint_lines()
    end,
    desc = 'line',
  },
  {
    '<leader>jp',
    function()
      hop.hint_patterns()
    end,
    desc = 'patterns',
  },
  {
    '<leader>jw',
    function()
      hop.hint_words()
    end,
    desc = 'words',
  },
})

-- dap shortcuts
pluginKeys.mapDAP = function()
  local dap = require('dap')
  local osv = require('osv')
  wk.add({
    { '<leader>d', group = 'debug' },
    {
      '<leader>dB',
      function()
        dap.clear_breakpoints()
      end,
      desc = 'Clear breakpoints',
    },
    {
      '<leader>db',
      function()
        dap.toggle_breakpoint()
      end,
      desc = 'Toggle breakpoint',
    },
    {
      '<leader>dc',
      function()
        dap.continue()
      end,
      desc = 'Continue run',
    },
    {
      '<leader>di',
      function()
        dap.step_into()
      end,
      desc = 'Step into',
    },
    {
      '<leader>dl',
      function()
        osv.launch({ port = 8086 })
      end,
      desc = 'Start lua debug',
    },
    {
      '<leader>dn',
      function()
        dap.step_over()
      end,
      desc = 'Step over',
    },
    {
      '<leader>do',
      function()
        dap.step_out()
      end,
      desc = 'Step out',
    },
    {
      '<leader>dq',
      function()
        dap.close()
        dap.terminate()
        dap.clear_breakpoints()
        require('dap.repl').close()
        require('dapui').close({})
      end,
      desc = 'Quit',
    },
    {
      '<leader>dr',
      function()
        dap.repl.toggle()
      end,
      desc = 'Toggle repl',
    },
    {
      '<leader>ds',
      function()
        dap.continue()
      end,
      desc = 'Start',
    },
  })
end

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
