local nnoremap = require('weskoerber.keymap').nnoremap
local tree = require('nvim-tree')

nnoremap('<leader>bb', tree.toggle)
