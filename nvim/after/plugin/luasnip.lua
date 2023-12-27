local ls = require('luasnip')
local ldr = require('luasnip.loaders.from_lua')

ls.config.set_config({
    history = false,
    enable_autosnippets = true,
})

ldr.load({ paths = '~/.config/nvim/lua/weskoerber/snippets/' })
