
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
  theme = 'base16',
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

local function setup()
  -- opts.options.theme = mk_theme()
  require("lualine").setup(opts)
end

return function ()
  setup()
  -- vim.api.nvim_create_autocmd("ColorScheme", {
  --   callback = setup
  -- })
end

