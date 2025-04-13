return {
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
      filesystem = {
        use_libuv_file_watcher = true
      },
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
            added     = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
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
}
