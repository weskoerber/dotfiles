local git_dir = vim.fn.FugitiveGitDir()
local commit_msg_path = vim.fs.joinpath(git_dir, 'COMMIT_EDITMSG')
local commit_msg_cache_path = vim.fs.joinpath(git_dir, '.last_commit_msg')

local function cache_commit_msg()
    if vim.fn.filereadable(commit_msg_path) == 1 then
        vim.fn.writefile(vim.fn.readfile(commit_msg_path), commit_msg_cache_path)
    else
        print('No commit message found (this is an error)')
    end
end

-- local function restore_commit_msg()
--     if vim.fn.filereadable(commit_msg_cache_path) == 1 then
--         vim.fn.writefile(vim.fn.readfile(commit_msg_cache_path), commit_msg_path)
--     else
--         print('No cached commit message found.')
--     end
-- end

-- vim.keymap.set('n', 'cc', function()
--     print('caching commit message')
--     cache_commit_msg()
--     vim.cmd('Git commit')
-- end)
--
-- vim.keymap.set('n', 'c.', function()
--     vim.cmd('Git commit')
--     vim.cmd('%delete | 0r ' .. commit_msg_cache_path)
-- end)
--
-- vim.api.nvim_create_autocmd('User', {
--     pattern = 'FugitiveCommit',
--     callback = function() print('FugitiveCommit') end,
-- })
