local Remap = require('weskoerber.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<C-n>', ':tabnew<CR>')
nnoremap('<C-w>', ':tabclose<CR>')
nnoremap('<C-]>', ':tabnex<CR>')
-- nnoremap('<C-[>', ':tabprevious<CR>')

nnoremap('<C-j>', ':winc j<CR>')
nnoremap('<C-k>', ':winc k<CR>')
nnoremap('<C-h>', ':winc h<CR>')
nnoremap('<C-l>', ':winc l<CR>')
