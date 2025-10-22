local oil = require('oil')
local view = require('oil.view')
local stringx = require('stringx')

vim.keymap.set('n', 'gop', function()
    local dest = vim.fn.input('Go to > ', '', 'file')
    oil.open(dest)
end, {})

vim.keymap.set('n', 'gor', function()
    -- TODO: figure out how to restore cursor position, as this causes the cursor to reset to origin
    oil.open(oil.get_current_dir())
end, {})

vim.keymap.set('n', 'goz', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum = vim.api.nvim_win_get_cursor(0)[1]

    local entry = oil.get_entry_on_line(bufnr, lnum)
    if not (entry) or entry.type ~= 'file' then
        return
    end

    local fext = string.gsub(entry.name, '.*%.', '')
    if fext ~= 'zip' then
        return
    end

    local aname = stringx.basename(entry.name, '.zip')

    local base = oil.get_current_dir(bufnr)
    local destdir = vim.fs.joinpath(base, aname)
    local srcfile = vim.fs.joinpath(base, entry.name)

    if vim.uv.fs_stat(destdir) then
        error('Unzip destination already exists: \'' .. destdir .. '\'')
    end

    vim.fn.mkdir(destdir, 'p')
    vim.system({ 'unzip', '-qq', srcfile, '-d', destdir }, function(res)
        if res.code ~= 0 or res.signal ~= 0 then
            error(string.format('unzip failed (code %d, signal %d): %s', res.code, res.signal, res.stderr))
        end
    end):wait()

    view.render_buffer_async(bufnr, {}, function() end)
end, {})
