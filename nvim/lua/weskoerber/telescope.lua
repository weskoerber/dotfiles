local telescope = require('telescope')

telescope.setup {
    defaults = {
        color_devicons = true,
        prompt_prefix = ' > ',
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        find_files = {
            find_command = { "fd", "--hidden", "--glob", "--no-ignore-vcs", "--ignore-file", "" },
        },
        diagnostics = {
            bufnr = nil,
        },
    },
}

require('telescope').load_extension('fzf')
