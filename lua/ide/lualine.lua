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

local bub_sep = { left = '', right = '' }

local custom_filename = {
  'filename',
  path = 1,
  symbols = { modified = "󰛄", readonly = "", unnamed = "", new = "" }
}

local custom_branch = {
  'branch',
  fmt = function(str)
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
    disabled_filetypes = { 'NvimTree', 'neo-tree' },
  },
  theme = 'base16',
  sections = {
    lualine_a = {
      { 'mode', separator = bub_sep, right_padding = 2 }
    },
    lualine_b = { custom_filename, custom_branch },
    lualine_c = { 'diff', { 'diagnostics', symbols = SIGNS_DIAGNOSTIC } },
    lualine_x = {
      { 'encoding',   fmt = empty_str_if_equal('utf-8') },
      { 'fileformat', fmt = empty_str_if_equal('unix') },
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = {
      { 'location', separator = bub_sep, left_padding = 2, }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { custom_filename },
    lualine_x = { 'location' }
  },
  extensions = { 'toggleterm', 'lazy' }
}

local function init()
  -- opts.options.theme = mk_theme()
  require("lualine").setup(opts)
end

return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'karaign/nvim-base16' },
    config = init
    -- See `:help lualine.txt`
}