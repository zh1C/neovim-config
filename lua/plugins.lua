local packer = require("packer")
packer.startup({
	function(use)
	-- Packer 可以管理自己本身
	use 'wbthomason/packer.nvim'
	-- 插件列表
	-- onedark colorscheme
	use 'navarasu/onedark.nvim'
	-- nvim-tree
	use {
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",  -- optional, for file icons
		},
	}
	-- which-key
	use 'folke/which-key.nvim'
	-- bufferline
	use {
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = {
			"nvim-tree/nvim-web-devicons",
			"moll/vim-bbye",
		},
	}
	-- lualine
	use {
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	}
	use 'arkav/lualine-lsp-progress'
	-- telescope
	use {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}
	-- dashboard
	use 'glepnir/dashboard-nvim'
	-- project
	use 'ahmedkhalf/project.nvim'
	-- treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
				local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
				ts_update()
		end,
	}
	-- lsp config
	use 'neovim/nvim-lspconfig'
	-- lsp installer
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	-- 补全引擎
	use 'hrsh7th/nvim-cmp'
	-- snippet 引擎
	use 'hrsh7th/vim-vsnip'
	--- 补全源
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
	use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
	use("hrsh7th/cmp-path") -- { name = 'path' }
	use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
	-- 常见编程语言代码段
	use("rafamadriz/friendly-snippets")
	-- ui
	use 'onsails/lspkind-nvim'
	use {
		"glepnir/lspsaga.nvim",
		branch = "main",
	}
  end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

-- 每次保存 plugin.lua 自动安装插件
pcall(
	vim.cmd,
	[[
		augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
		augroup end
	]]
)
