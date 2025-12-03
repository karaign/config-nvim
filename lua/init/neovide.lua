local cwd = vim.fn.getcwd()
if cwd == '/' or string.find(cwd, 'C:\\Program Files') then
  vim.fn.chdir('~')
end

-- Set up font
vim.o.guifont = "BlexMono Nerd Font Mono:h13"

-- Set up scale
local DEFAULT_SCALE = PS(0.83333, 1.0)
vim.g.neovide_scale_factor = DEFAULT_SCALE
-- Add padding
vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10

local cmd = PS('<M-', '<D-', '<M-')
-- Basic GUI keybinds
vim.keymap.set('n', cmd..'s>', ':w<CR>')        -- Save
vim.keymap.set('v', cmd..'c>', '"+y')           -- Copy
vim.keymap.set('n', cmd..'v>', '"+P')           -- Paste normal mode
vim.keymap.set('v', cmd..'v>', '"+P')           -- Paste visual mtestode
vim.keymap.set('c', cmd..'v>', '<C-R>+')        -- Paste command mode
vim.keymap.set('i', cmd..'v>', '<ESC>l"+Pli')   -- Paste insert mode
vim.keymap.set('n', cmd..'w>', ':q<CR>')        -- Close window
vim.keymap.set('n', '<C-q>', ':qa<CR>')       -- Close neovim
vim.keymap.set('n', cmd..'t>', ':tabnew<CR>')   -- New tab
vim.keymap.set('n', cmd..'a>', 'ggVG<CR>')      -- Select all
vim.keymap.set('i', cmd..'a>', '<Esc>ggVG<CR>') -- Select all


-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', cmd..'v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', cmd..'v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', cmd..'v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', cmd..'v>', '<C-R>+', { noremap = true, silent = true })

-- Dynamic resizing
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

local niv = {'n', 'i', 'v'}

vim.keymap.set(niv, cmd..'=>', function()
  change_scale_factor(1.2)
end)

vim.keymap.set(niv, cmd..'->', function()
  change_scale_factor(1 / 1.2)
end)

vim.keymap.set(niv, cmd..'0>', function()
  vim.g.neovide_scale_factor = DEFAULT_SCALE
end)

-- Set up animations
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false


-- Set up nice titlebar on Windows
if PLATFORM == 'Windows_NT' then
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function ()
      local hl = vim.api.nvim_get_hl(0, {name="Normal"})

      vim.g.neovide_title_background_color = string.format("%06x", hl.bg)
      vim.g.neovide_title_text_color = string.format("%06x", hl.fg)
    end
  })
end
