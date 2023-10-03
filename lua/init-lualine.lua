
local function empty_str_if_equal(eq_to)
  return function(str)
    if str == eq_to then
      return ''
    else
      return str
    end
  end
end

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local bub_sep = {left = '', right = ''}

local custom_filename = {
  'filename',
  symbols = { modified = "󰛄", readonly = "", unnamed = "", new = ""}
}

local custom_branch = {
  'branch',
  fmt = function (str)
    if str == "" then
      return ""
    end
    return "󰘬 " .. str
  end,
}


local opts = {
  options = {
    icons_enabled = false,
    component_separators = '·',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {'NvimTree', 'neo-tree'},
  },
  sections = {
    lualine_a = {
      { 'mode', separator = bub_sep, right_padding = 2 }
    },
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = { custom_filename },
    lualine_x = {
      custom_branch,
      {'encoding', fmt = empty_str_if_equal('utf-8')},
      {'fileformat', fmt = empty_str_if_equal('unix')},
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {
     { 'location', separator = bub_sep, left_padding = 2, }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {custom_filename},
    lualine_x = {custom_branch, 'location'}
  },
  extensions = {'toggleterm', 'lazy'}
}
  -- I dislike both the auto-genned colorscheme
  -- and the themer-genned colorscheme for diff.
  -- reasons, so I'll cobble together a custom
  -- one using themer as a base:
local function mk_theme()
---@diagnostic disable: need-check-nil
---@diagnostic disable: undefined-field
  -- it's fine trust me
  local colors = require("themer.modules.core.api").get_cp(require("themer.config")("get").colorscheme)
  local my_thm = {}

  local insert = colors.syntax.string
  local normal = colors.syntax['function']
  local visual = colors.syntax.keyword
  local replace = colors.diagnostic.error
  local command = colors.syntax.constant

  my_thm.normal = {
    a = { bg = normal, fg = colors.bg.alt, gui = "bold" },
    b = { bg = colors.bg.selected, fg = normal},
    c = { bg = colors.bg.alt, fg = colors.dimmed.subtle },
  }

  my_thm.insert = {
    a = { bg = insert, fg = colors.bg.alt , gui = "bold"},
    b = { bg = colors.bg.selected, fg = insert },
  }

  my_thm.command = {
    a = { bg = command, fg = colors.bg.alt, gui = "bold" },
    b = { bg = colors.bg.selected, fg = command },
  }

  my_thm.visual = {
    a = { bg = visual, fg = colors.bg.alt, gui = "bold" },
    b = { bg = colors.bg.selected, fg = visual },
  }

  my_thm.replace = {
    a = { bg = replace, fg = colors.bg.alt, gui = "bold" },
    b = { bg = colors.bg.selected, fg = replace},
  }

  my_thm.inactive = {
    a = { bg = colors.bg.selected, fg = colors.dimmed.subtle},
    b = { bg = colors.bg.alt, fg = colors.dimmed.subtle, gui = "bold" },
    c = { bg = colors.bg.alt, fg = colors.dimmed.subtle },
  }

  return my_thm
end

local function setup()
  opts.options.theme = mk_theme()
  require("lualine").setup(opts)
end

return function ()
  setup()
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = setup
  })
end

