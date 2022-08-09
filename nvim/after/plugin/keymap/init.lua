local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>tt', ':tabnew<CR>')
nnoremap('<leader>tc', ':tabclose<CR>')
nnoremap('<leader>tn', ':tabnex<CR>')
nnoremap('<leader>tp', ':tabprev<CR>')
