-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local nvim_logo = {
	[[                                   __                ]],
	[[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

local kitty = {
	"          |\\      _,,,---,,_            ",
	"    ZZZzz /,`.-'`'    -.  ;-;;,_        ",
	"         |,4-  ) )-,_. ,\\ (  `'-'       ",
	"        '---''(_/--'  `-'\\_)  Felix Lee "
}

local SESSION_DIR = "~/.config/nvim/sessions"

return {
  {
    "startup-nvim/startup.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    config = function ()
    	require("startup").setup()
    end
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
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
      require("neoclip").setup()
      require("telescope").load_extension("neoclip")
      vim.keymap.set('n', '<leader>p', require("telescope").extensions.neoclip.neoclip, { desc = "[P]aste from history "})
    end
  }
}
