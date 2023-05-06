local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<C-n>', ':tabnew<CR>')
nnoremap('<C-w>', ':tabclose<CR>')
nnoremap('<C-]>', ':tabnex<CR>')
-- nnoremap('<C-[>', ':tabprevious<CR>')

nnoremap('<leader>j', ':winc j<CR>')
nnoremap('<leader>k', ':winc k<CR>')
nnoremap('<leader>h', ':winc h<CR>')
nnoremap('<leader>l', ':winc l<CR>')
