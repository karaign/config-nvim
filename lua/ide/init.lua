--- This folder is for plugins that should only be run when nvim is being
--- used as a standalone application i.e. a makeshift IDE.

return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  
  -- Always open help in vsplit
  {
    'karaign/help-vsplit.nvim',
    config = function()
      require('help-vsplit').setup({
        side = 'left'
      })
    end
  },


  -- Coloescheme setup
  {
    'karaign/nvim-base16',
    priority = 1001,
    config = function()
      require('base16-colorscheme').with_config({
        telescope = true
      })
      vim.cmd('colorscheme base16-' .. MY_COLORSCHEME)
    end
  },


  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      indent = {
        char = '┊',
      }
    },
  },

  -- popup terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<c-`>]],
        shade_terminals = true,
        shell = '/usr/local/bin/fish',
        direction = 'float',
        float_opts = {
          border = 'single',
          width = 90,
          height = 20
        }
      })
    end
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end
  },


  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview [H]unk' })
      end,
    },
  },


  { -- neovim LSP for neovim, such meta, wow
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "rmagatti/auto-session",
    config = function ()
    	require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Developer", "/"}
      }
    end
  },

  {
    "Olical/conjure",
    config = function ()
    	vim.g["conjure#mapping#prefix"] = "<leader>c"
    end
  },

  {
    "clojure-vim/vim-jack-in",
    dependencies = {"tpope/vim-dispatch", "radenling/vim-dispatch-neovim"}
  },

  -- {
  --   "kevinhwang91/nvim-hlslens",
  --   config = function ()
  --     require('hlslens').setup()
  --
  --     local kopts = {noremap = true, silent = true}
  --
  --     vim.api.nvim_set_keymap('n', 'n',
  --     [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  --     kopts)
  --     vim.api.nvim_set_keymap('n', 'N',
  --     [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  --     kopts)
  --     vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --     vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --
  --     vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
  --   end
  -- },
  --
  -- {
  --   "petertriho/nvim-scrollbar",
  --   dependencies = {
  --     "lewis6991/gitsigns.nvim",
  --     "kevinhwang91/nvim-hlslens"
  --   },
  --   config = function ()
  --   	require("scrollbar").setup({
  --
  --     })
  --   end
  -- },
  --

  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
      config = function ()
    	require("telescope").load_extension("session-lens")
	vim.keymap.set('n', '<leader>ss', require('session-lens').search_session, { desc = '[S]earch [S]essions' })
    end
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function ()
      require("neoclip").setup({
	keys = {telescope = { i = { paste = "<cr>", select = "<c-b>" } } } -- b for bump!
      })
      require("telescope").load_extension("neoclip")
      vim.keymap.set('n', '"p', require("telescope").extensions.neoclip.neoclip, { desc = "[P]aste from history"})
    end
  }
}
