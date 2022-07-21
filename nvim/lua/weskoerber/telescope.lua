local telescope = require('telescope')

telescope.setup {
    defaults = {
        color_devicons = true,
        prompt_prefix = ' > ',
    },
    extensions = {
        frecency = {
            override_generic_sorter = false,
            override_file_sorter = true,
            show_scores = true,
        },
    },
}

telescope.load_extension('frecency')
-- telescope.load_extension('fzf_native')
