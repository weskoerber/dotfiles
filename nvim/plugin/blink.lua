local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup({
    signature = {
        enabled = true,
    },
})
