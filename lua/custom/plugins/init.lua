-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information


return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
      vim.keymap.set('n', '<leader>f', require("telescope").extensions.file_browser.file_browser,
	{ desc = 'Browse [f]iles' })
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
      require("neoclip").setup({
	keys = {telescope = { i = { paste = "<cr>", select = "<c-b>" } } } -- b for bump!
      })
      require("telescope").load_extension("neoclip")
      vim.keymap.set('n', '<leader>p', require("telescope").extensions.neoclip.neoclip, { desc = "[P]aste from history"})
    end
  }
}
