local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup({
    completion = {
        documentation = { auto_show = true },
    },
    keymap = { preset = 'default' },
    signature = {
        enabled = true,
        trigger = { show_on_insert = true },
    },
})
