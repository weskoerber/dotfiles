local nnoremap = require('weskoerber.keymap').nnoremap
local tree = require('nvim-tree')

nnoremap('<C-y>', tree.toggle)
