require('obsidian').setup({
    workspaces = {
        {
            name = 'work',
            path = '~/Documents/notes/acsd',
        },
        {
            name = 'personal',
            path = '~/Documents/notes/personal',
        },
    },
    detect_cwd = true,
    disable_frontmatter = true,
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
    end, { noremap = false, expr = true }),

    vim.keymap.set("n", "<leader>ovt", function()
        vim.cmd("vertical sbuffer | ObsidianToday")
    end),

    vim.keymap.set("n", "<leader>ovy", function()
        vim.cmd("vertical sbuffer | ObsidianYesterday")
    end),

    vim.keymap.set("n", "<leader>ovn", function()
        vim.cmd("vertical sbuffer | ObsidianNew")
    end)
})
