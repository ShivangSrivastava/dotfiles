local client_id = vim.lsp.start({
  name = 'vani',
  cmd = { '/home/shivang/personal/vani/vani' },
})

if not client_id then
  vim.notify("Vani LSP: failed to start client", vim.log.levels.ERROR)
  return
end

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "markdown",
  callback = function(args)
    local ok = vim.lsp.buf_is_attached(args.buf, client_id)
    if not ok then
      vim.lsp.buf_attach_client(args.buf, client_id)
    end
  end
})
