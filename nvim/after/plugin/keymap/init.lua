local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>ttc', ':tabnew<CR>')
nnoremap('<leader>ttx', ':tabclose<CR>')
nnoremap('<leader>ttn', ':tabnex<CR>')
nnoremap('<leader>ttp', ':tabprevious<CR>')

nnoremap('<C-j>', ':winc j<CR>')
nnoremap('<C-k>', ':winc k<CR>')
nnoremap('<C-h>', ':winc h<CR>')
nnoremap('<C-l>', ':winc l<CR>')
