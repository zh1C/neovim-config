local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({
  ------------------------plugins-------------------------
  -- onedark colorscheme
  { 'navarasu/onedark.nvim' },

  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('plugin-config.nvim-tree')
    end,
  },

  -- auto-save
  -- {
  -- 	'Pocco81/auto-save.nvim',
  -- 	config = function()
  -- 		require('plugin-config.auto-save')
  -- 	end,
  -- },

  -- zen-mode
  {
    'folke/zen-mode.nvim',
    config = function()
      require('plugin-config.zen-mode')
    end,
  },

  -- noice
  -- {
  -- 	'folke/noice.nvim',
  -- 	requires = {
  -- 		'MunifTanjim/nui.nvim',
  -- 		'rcarriga/nvim-notify',
  -- 	},
  -- 	config = function()
  -- 		require('plugin-config.noice')
  -- 	end,
  -- },

  -- indent-blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugin-config.indent-blankline')
    end,
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin-config.gitsigns')
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    config = function()
      require('plugin-config.which-key')
    end,
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'moll/vim-bbye',
    },
    config = function()
      require('plugin-config.bufferline')
    end,
  },

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugin-config.lualine')
    end,
  },
  { 'arkav/lualine-lsp-progress' },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugin-config.telescope')
    end,
  },

  -- dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugin-config.dashboard')
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- project
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('plugin-config.project')
    end,
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugin-config.nvim-treesitter')
    end,
  },

  -- nvim-autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugin-config.nvim-autopairs')
    end,
  },

  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugin-config.comment')
    end,
  },

  -- nvim-surround
  {
    'kylechui/nvim-surround',
    config = function()
      require('plugin-config.surround')
    end,
  },

  -- jump hop
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('plugin-config.hop-config')
    end,
  },

  -- toggleterm
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugin-config.toggleterm')
    end,
  },

  ---------------------------LSP---------------------------------
  -- lsp config
  { 'neovim/nvim-lspconfig' },
  -- lsp installer
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  -- coc
  {
    'neoclide/coc.nvim',
    branch = 'release',
  },

  -- vim-go
  {
	  'fatih/vim-go',
  },

  --------------------------cmp----------------------------------
  -- 补全引擎
  { 'hrsh7th/nvim-cmp' },
  -- snippet 引擎
  { 'hrsh7th/vim-vsnip' },
  --- 补全源
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/cmp-nvim-lsp' }, -- { name = nvim_lsp }
  { 'hrsh7th/cmp-buffer' }, -- { name = 'buffer' },
  { 'hrsh7th/cmp-path' }, -- { name = 'path' }
  { 'hrsh7th/cmp-cmdline' }, -- { name = 'cmdline' }
  { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- { name = 'nvim_lsp_signature_help' }
  -- 常见编程语言代码段
  { 'rafamadriz/friendly-snippets' },

  -- ui
  { 'onsails/lspkind-nvim' },
  {
    'nvimdev/lspsaga.nvim',
	dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugin-config.lspsaga')
    end,
  },

  -------------------------format and diagnostic------------------
  -- 代码格式化
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },

  -------------------------dap------------------------------------
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'jbyuki/one-small-step-for-vimkind' },

  ------------------------ End plugin-----------------------------
})
