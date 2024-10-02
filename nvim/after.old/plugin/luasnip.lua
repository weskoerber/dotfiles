local ls = require('luasnip')

ls.config.set_config({
    history = false,
    enable_autosnippets = true,
})

require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/weskoerber/snippets/' })
require('luasnip.loaders.from_vscode').lazy_load()
