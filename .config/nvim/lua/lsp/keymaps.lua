local M = {}

function M.keymaps(event)
  local smart_format = require("lsp.format").smart_format
  local opts = { buffer = event.buf, silent = true }
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({ 'n', 'x' }, '<F3>', smart_format, opts)
  vim.keymap.set('n', '<F4>', "<cmd>FzfLua lsp_code_actions<CR>", opts)
  vim.keymap.set('n', '<leader>o',
    ":lua vim.lsp.buf.code_action{context={only={\"source.organizeImports\"}},apply=true}<CR>", opts)
  -- Diagnostic navigation
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>', opts)
  vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>', opts)
  vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)
end

return M
