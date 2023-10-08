if vim.fn.getcwd() == '/' then
  vim.fn.chdir('~')
end

-- Set up font
vim.o.guifont = "BlexMono Nerd Font Mono:h12"

-- Set up scale
local DEFAULT_SCALE = 1.0
vim.g.neovide_scale_factor = DEFAULT_SCALE
-- Add padding
vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10

-- Mac OS keybinds
vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mtestode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set('n', '<D-w>', ':q<CR>') -- Close window
vim.keymap.set('n', '<C-q>', ':qa<CR>') -- Close neovim
vim.keymap.set('n', '<D-t>', ':tabnew<CR>') -- New tab
vim.keymap.set('n', '<D-a>', 'ggVG<CR>') -- Select all
vim.keymap.set('i', '<D-a>', '<Esc>ggVG<CR>') -- Select all


-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- Dynamic resizing
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<D-=>", function()
  change_scale_factor(1.2)
end)

vim.keymap.set("n", "<D-->", function()
  change_scale_factor(1/1.2)
end)

vim.keymap.set("n", "<D-0>", function ()
  vim.g.neovide_scale_factor = DEFAULT_SCALE
end)

-- Set up animations
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false

-- Set up titlebar color

local function auto_set_titlebar_color()
  local color = vim.api.nvim_get_hl(0, {name = 'VertSplit'}).bg
  -- local color = vim.api.nvim_get_hl(0, {name = 'VertSplit'}).bg
  vim.g.neovide_background_color = '#' .. string.format("%06x", color)
end

if vim.g.neovide then
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = auto_set_titlebar_color
  })
end
