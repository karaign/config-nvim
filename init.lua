-- First things first, set preferred colorscheme
-- TODO: Ability to change this at runtime
MY_COLORSCHEME = 'ayu-dark'

-- OS-specific things
PLATFORM = vim.loop.os_uname().sysname

-- Shorthand func for selecting stuff based on platform
-- When called with 2 args, opt1 is WIN and opt2 is UNIX
-- When called with 3 args, opt1 is WIN, opt2 is Mac and opt3 is Linux
PS = function (opt1, opt2, opt3)
  if PLATFORM == 'Windows_NT' then
    return opt1
  elseif PLATFORM == 'Darwin' or opt3 == nil then
    return opt2
  else
    return opt3 -- Assuming Linux because... seriously
  end
end

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.fillchars = 'vert:‧,horiz:‧'

-- Install package manager
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Neovide specific
if vim.g.neovide then
  require("init.neovide")
end

-- [[ Setting options ]]
-- See `:help vim.uo`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Terminal settings
vim.o.shell = PS('pwsh', '/usr/local/bin/fish')
vim.o.termguicolors = true
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Are we running inside VSCode or standalone?
if vim.g.vscode then
  -- Initialize package manager to only load editing-related plugins
  require('lazy').setup({
    spec = {
      { import = 'editor' }
    }
  })
  -- Load other vscode-specific settings
  require('init.vscode')
else -- Running standalone
  -- Initialize package manager to load all plugins
  require('lazy').setup({
    spec = {
      { import = 'editor' },
      { import = 'ide' }
    }
  })
  -- make nvim shut up about the mouse
  vim.cmd('aunmenu PopUp.How-to\\ disable\\ mouse')
  vim.cmd('aunmenu PopUp.-1-')
  vim.cmd('aunmenu PopUp.-2-')

  -- configure diagnostics
  require('init.diagnostics')

  -- Enable mouse mode
  vim.o.mouse = 'a'

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'
  vim.o.nu = true
end
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
