-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information


return {
  {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	"MunifTanjim/nui.nvim",
      },
    config = function ()
      require("neo-tree").setup({
	enable_diagnostics = false,
	window = {
	  mappings = {
	    ["<space>"] = {
	      nowait = false
	    }
	  },
	},
	default_component_configs = {
	  modified = {
	    symbol = "󰛄"
	  },
	  git_status = {
	    symbols = {
	      -- Change type
	      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
	      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
	      deleted   = "",-- this can only be used in the git_status source
	      renamed   = "",-- this can only be used in the git_status source
	      -- Status type
	      untracked = "",
	      ignored   = "",
	      unstaged  = "󰇂",
	      staged    = "",
	      conflict  = "",
	    }
	  }
	},
	source_selector = {
	  statusline = true,
	  separator = { left = ' ', right = ' '},
	  separator_active = { left = '', right = ''},
	  show_separator_on_edge = true,
	  highlight_tab = "lualine_c_inactive",
	  highlight_tab_active = "lualine_b_normal",
	  highlight_background = "lualine_c_normal",
	  highlight_separator_active = "lualine_transitional_lualine_b_normal_to_lualine_c_normal",
	  highlight_separator = "lualine_c_inactive"
	},
	auto_clean_after_session_restore = true,
	buffers = {
	  show_unloaded = true,
	  terminals_first = true,
	  bind_to_cwd = false
	}
      })

      vim.keymap.set('n', '<leader>ft', function ()
      	vim.cmd('Neotree toggle')
      end, { desc = '[F]ile [T]ree'})
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
      vim.keymap.set('n', '<leader>fb', require("telescope").extensions.file_browser.file_browser,
	{ desc = '[F]ile [B]rowser' })
    end
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

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
