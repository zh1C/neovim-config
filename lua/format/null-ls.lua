local status, null_ls = pcall(require, 'null-ls')
if not status then
  vim.notify('没有找到 null-ls')
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  debug = false,
  -- you can find formatting sources from this url
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  sources = {
    -- Formatting ---------------------
    -- StyLua formatting
    -- brew install stylua
    formatting.stylua,

    -- golang fotmatting
    -- go install ......
    formatting.gofmt,
    formatting.goimports,

    -- python formatting
    -- pip install autoflake isort yapf
    formatting.yapf,
    formatting.autoflake,
    formatting.isort,

    -- diagnostics
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    diagnostics.flake8,
    diagnostics.golangci_lint.with({
      extra_args = { '-E', 'gosimple', '-E', 'unused', '-E', 'errcheck', '-E', 'govet', '-E', 'staticcheck' },
    }),
  },
  -- 保存自动格式化
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
