local util

function util.keymap(modes, keys, func, desc)
  vim.keymap.set(modes, keys, func, { desc = desc })
end

return util
