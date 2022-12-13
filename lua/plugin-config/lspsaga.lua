local saga = require('lspsaga')
saga.init_lsp_saga({
	-- configuration
	rename_action_quit = '<C-g>',
	finder_action_keys = {
			open = {'o', '<CR>'},
			vsplit = 's',
			split = 'i',
			tabe = 't',
			quit = {'q', '<ESC>'},
	},
	code_action_keys = {
			quit = 'q',
			exec = '<CR>',
	},
	definition_action_keys = {
		edit = '<C-c>o',
		vsplit = '<C-c>v',
		split = '<C-c>i',
		tabe = '<C-c>t',
		quit = 'q',
	},
	-- show symbols in winbar must nightly
	-- in_custom mean use lspsaga api to get symbols
	-- and set it to your custom winbar or some winbar plugins.
	-- if in_cusomt = true you must set in_enable to false
	symbol_in_winbar = {
			enable = true,
	},
})
