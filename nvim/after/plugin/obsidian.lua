local config = {
    workspaces = {
        '~/Documents/notes/personal',
        '~/Documents/notes/acsd',
    },
    finder = 'telescope.nvim',

    -- Optional, completion.
    completion = {
        -- If using nvim-cmp, otherwise set to false
        nvim_cmp = true,
        -- Trigger completion at 2 chars
        min_chars = 1,
        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir"
    },
    -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
    -- see also: 'follow_url_func' config option below.
    vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
        else
            return "gf"
        end
    end, { noremap = false, expr = true })
}

local obsidian = require('obsidian')
local setup_obsidian = function()
    for _, val in pairs(config.workspaces) do
        if vim.fs.normalize(val) == vim.fn.getcwd() then
            obsidian.setup(vim.tbl_extend('error', config, {dir = val}))
            break
        end
    end
end

setup_obsidian()
