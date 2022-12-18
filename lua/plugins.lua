local packer = require('packer')
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use('wbthomason/packer.nvim')
    ------------------------plugins-------------------------
    -- onedark colorscheme
    use('navarasu/onedark.nvim')

    -- nvim-tree
    use({
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      config = function()
        require('plugin-config.nvim-tree')
      end,
    })

    -- auto-save
    -- use({
    --   'Pocco81/auto-save.nvim',
    --   config = function()
    --     require('plugin-config.auto-save')
    --   end,
    -- })

    -- zen-mode
    use({
      'folke/zen-mode.nvim',
      config = function()
        require('plugin-config.zen-mode')
      end,
    })

    -- indent-blankline
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugin-config.indent-blankline')
      end,
    })

    -- gitsigns
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugin-config.gitsigns')
      end,
    })

    -- which-key
    use({
      'folke/which-key.nvim',
      config = function()
        require('plugin-config.which-key')
      end,
    })

    -- bufferline
    use({
      'akinsho/bufferline.nvim',
      tag = 'v3.*',
      requires = {
        'nvim-tree/nvim-web-devicons',
        'moll/vim-bbye',
      },
      config = function()
        require('plugin-config.bufferline')
      end,
    })

    -- lualine
    use({
      'nvim-lualine/lualine.nvim',
      requires = {
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require('plugin-config.lualine')
      end,
    })
    use('arkav/lualine-lsp-progress')

    -- telescope
    use({
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('plugin-config.telescope')
      end,
    })

    -- dashboard
    use({
      'glepnir/dashboard-nvim',
      config = function()
        require('plugin-config.dashboard')
      end,
    })

    -- project
    use({
      'ahmedkhalf/project.nvim',
      config = function()
        require('plugin-config.project')
      end,
    })

    -- nvim-treesitter
    use({
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require('plugin-config.nvim-treesitter')
      end,
    })

    -- nvim-autopairs
    use({
      'windwp/nvim-autopairs',
      config = function()
        require('plugin-config.nvim-autopairs')
      end,
    })

    -- Comment.nvim
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('plugin-config.comment')
      end,
    })

    -- nvim-surround
    use({
      'kylechui/nvim-surround',
      config = function()
        require('plugin-config.surround')
      end,
    })

    -- jump hop
    use({
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        require('plugin-config.hop')
      end,
    })

    -- toggleterm
    use({
      'akinsho/toggleterm.nvim',
      config = function()
        require('plugin-config.toggleterm')
      end,
    })

    ---------------------------LSP---------------------------------
    -- lsp config
    use('neovim/nvim-lspconfig')
    -- lsp installer
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    -- 补全引擎
    use('hrsh7th/nvim-cmp')
    -- snippet 引擎
    use('hrsh7th/vim-vsnip')
    --- 补全源
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
    use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
    use('hrsh7th/cmp-path') -- { name = 'path' }
    use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
    use('hrsh7th/cmp-nvim-lsp-signature-help') -- { name = 'nvim_lsp_signature_help' }
    -- 常见编程语言代码段
    use('rafamadriz/friendly-snippets')

    -- ui
    use('onsails/lspkind-nvim')
    use({
      'glepnir/lspsaga.nvim',
      branch = 'main',
      config = function()
        require('plugin-config.lspsaga')
      end,
    })

    -- 代码格式化
    use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })

    ------------------------ End plugin------------------------
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})

-- 每次保存 plugin.lua 自动安装插件
-- pcall(
--   vim.cmd,
--   [[
-- 		augroup packer_user_config
-- 		autocmd!
-- 		autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- 		augroup end
-- 	]]
-- )
