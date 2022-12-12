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

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
	n = {
		-- nomal mode 关闭窗口
		["<C-c>"] = "close",
	},
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
		f = {":Telescope find_files<CR>", "find file", mode="n", opt},
		o = {":Telescope oldfiles<CR>", "open recent file", mode="n", opt},
		k = {":e ~/.config/nvim/lua/keybindings.lua<CR>", "edit keybinding", mode="n", opt},
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
		b = {":Telescope buffers<CR>", "List buffers", mode="n", opt},
		["1"] = {":BufferLineGoToBuffer 1<CR>", "Go to buffer 1", mode="n", opt},	
		["2"] = {":BufferLineGoToBuffer 2<CR>", "Go to buffer 2", mode="n", opt},	
		["3"] = {":BufferLineGoToBuffer 3<CR>", "Go to buffer 3", mode="n", opt},	
		["4"] = {":BufferLineGoToBuffer 4<CR>", "Go to buffer 4", mode="n", opt},	
		["5"] = {":BufferLineGoToBuffer 5<CR>", "Go to buffer 5", mode="n", opt},	
		["6"] = {":BufferLineGoToBuffer 6<CR>", "Go to buffer 6", mode="n", opt},	
		["7"] = {":BufferLineGoToBuffer 7<CR>", "Go to buffer 7", mode="n", opt},	
		["8"] = {":BufferLineGoToBuffer 8<CR>", "Go to buffer 8", mode="n", opt},	
		["9"] = {":BufferLineGoToBuffer 9<CR>", "Go to buffer 9", mode="n", opt},	
	},
}, { prefix = "<leader>" })

-- search shortcuts
wk.register({
	s = {
		name = "search",
		s = {":Telescope current_buffer_fuzzy_find<CR>", "search current buffer", mode="n", opt},
	},
}, { prefix = "<leader>" })

-- project shortcuts
wk.register({
	p = {
		name = "project",
		p = {":Telescope projects<CR>", "open project", mode="n", opt},
	},
}, { prefix = "<leader>" })


-- 返回nvim-tree 的快捷键列表
return pluginKeys
