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

local settings = {
    -- every line should be same width without escaped \
    header = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 5,
        content = nvim_logo,
        highlight = "Statement",
        default_color = "",
        oldfiles_amount = 0,
    },
    -- name which will be displayed and command
    body = {
        type = "mapping",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Basic Commands",
        margin = 5,
        content = {
            { "󰈞 Find File", "Telescope find_files", "sf" },
            { "󱎸 Find Word", "Telescope live_grep", "sg" },
            { "󱂬 Recent Sessions", "Telescope session-lens search_session", "ss"},
            { "󰋚 Recent Files", "Telescope oldfiles", "of" },
            { "󱘲 File Browser", "Telescope file_browser", "fb" },
            { "󰏘 Colorschemes", "Telescope themes", "cs" },
            { "󰈔 New File", "lua require'startup'.new_file()", "nf" },
        },
        highlight = "String",
        default_color = "",
        oldfiles_amount = 0,
    },
    footer = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Footer",
        margin = 5,
        content = kitty,
        highlight = "Number",
        default_color = "",
        oldfiles_amount = 0,
    },

    options = {
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = true,
        disable_statuslines = true,
        paddings = { 1, 3, 3, 0 },
    },
    mappings = {
        execute_command = "<CR>",
        open_file = "o",
        open_file_split = "<c-o>",
        open_section = "<TAB>",
        open_help = "?",
    },
    colors = {
        background = "#1f2227",
        folded_section = "#56b6c2",
    },
    parts = { "header", "body", "footer" },
}

return {
  {
    "startup-nvim/startup.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    config = function ()
    	require("startup").setup(settings)
    end
  },
}
