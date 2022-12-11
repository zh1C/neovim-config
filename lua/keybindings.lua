-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用opt参数
local opt = {noremap = true, silent = true }

-- 退出insert mode到normal mode
map("i", "jk", "<ESC>", opt)
-- 退出visual mode到normal mode
map("v", "jk", "<ESC>", opt)

-- nvim-tree 插件快捷键
local pluginKeys = {}
-- nvim-tree 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "f", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}

-- use which-key mapping
local status, wk = pcall(require, "which-key")
if not status then
	vim.notify("没有找到 which-key")
	return
end

-- file shortcuts
wk.register({
	f = {
		name = "Files",
		s = {":w<CR>", "Save", mode="n", opt},
		-- nvim-tree plugin
		t = {":NvimTreeToggle<CR>", "open/hiden file tree", mode="n", opt},
	},
}, { prefix = "<leader>" })

-- quit shortcuts
wk.register({
	q = {
		name = "quit",
		q = {":q<CR>", "quit neovim", mode="n", opt},
	},
}, { prefix = "<leader>" })

-- windows shortcuts
wk.register({
	w = {
		name = "windows",
		v = {":vsp<CR>", "split window right", mode="n", opt},
		s = {":sp<CR>", "split window below", mode="n", opt},
		d = {"<C-w>c", "delete currrent window", mode="n", opt},
		o = {"<C-w>o", "delete other windows", mode="n", opt},
	},
}, { prefix = "<leader>" })

-- buffer line shortcuts
wk.register({
	b = {
		name = "buffers",
		c = {":BufferLinePickClose<CR>", "Choose buffer close", mode="n", opt},
		p = {":BufferLineCyclePrev<CR>", "Previous buffer", mode="n", opt},
		n = {":BufferLineCycleNext<CR>", "Next buffer", mode="n", opt},
		d = {":Bdelete!<CR>", "Kill buffer", mode="n", opt},
	},
}, { prefix = "<leader>" })


-- 返回nvim-tree 的快捷键列表
return pluginKeys
