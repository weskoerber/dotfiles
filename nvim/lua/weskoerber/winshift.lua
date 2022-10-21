require('winshift').setup({ highlight_moving_win = true,
    focused_hl_group = 'Visual',
    moving_win_options = {
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = '',
    },
    keymaps = {
        disable_defaults = false,
        -- win_move_mode = {
        -- },
    },

    window_picker = function()
        return require('winshift.lib').pick_window({
            picker_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            filter_rules = {
                cur_win = true,
                floats = true,
                filetype = {},
                buftype = {},
                bufname = {},
            },
            filter_func = nil,
        })
    end
})

