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
	use {
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = {
			"nvim-tree/nvim-web-devicons",
			"moll/vim-bbye",
		},
	}
	use {
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	}
	use 'arkav/lualine-lsp-progress'
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
