-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- auto install coc extensions
vim.g.coc_global_extensions = {
								'coc-json', 'coc-lua',
								'coc-go', 'coc-sh', 'coc-markdownlint',
								'coc-markdown-preview-enhanced',
								'coc-webview',
								'coc-yaml'
							}
