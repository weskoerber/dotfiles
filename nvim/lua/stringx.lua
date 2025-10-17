local M = {
    ---@param path string
    ---@param ext string|nil
    ---@return string
    basename = function(path, ext)
        local basename = vim.fs.basename(path)
        if ext then
            return string.gsub(basename, ext, '', 1) or basename
        else
            return basename
        end
    end,
}

return M
