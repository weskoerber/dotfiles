local telescope = require('telescope')

telescope.setup {
    defaults = {
        color_devicons = true,
        prompt_prefix = ' > ',
    },
    extensions = {
    },
}

-- telescope.load_extension('fzf_native')
