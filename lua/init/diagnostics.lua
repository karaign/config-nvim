-- vim.diagnostic.config({
--   -- Only show virtual text for errors
--   virtual_text = {
--     severity = vim.diagnostic.severity.ERROR
--   },
--   -- Only underline errors
--   underline = {
--     severity = vim.diagnostic.severity.ERROR
--   }
-- })
--
-- Change signs
local function set_sign(name, sign)
  vim.fn.sign_define(name, { text = sign, texthl = name })
end

local function capitalized(str)
  return (str:gsub("^%l", string.upper))
end

for k, v in pairs(SIGNS_DIAGNOSTIC) do
  set_sign('DiagnosticSign' .. capitalized(k), v)
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
