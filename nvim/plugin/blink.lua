local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup({
    signature = {
        enabled = true,
        trigger = {
            show_on_insert = true,
        },
    },
})
