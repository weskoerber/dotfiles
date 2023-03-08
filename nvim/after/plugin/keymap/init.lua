local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>ttc', ':tabnew<CR>')
nnoremap('<leader>ttx', ':tabclose<CR>')
nnoremap('<leader>ttn', ':tabnex<CR>')
nnoremap('<leader>ttp', ':tabprevious<CR>')

nnoremap('<leader>j', ':winc j<CR>')
nnoremap('<leader>k', ':winc k<CR>')
nnoremap('<leader>h', ':winc h<CR>')
nnoremap('<leader>l', ':winc l<CR>')
