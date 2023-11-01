local lualine_config = require('weskoerber.lualine_config')
local lualine = require('lualine')

---@class Color
---@field overrides table<function> Color sheme overrides
local Color = {}

---Configures lualine theme
---@param theme string Theme name
local function setup_lualine(theme)
    if lualine_config.options == nil then
        lualine_config.options = { theme = theme }
    else
        lualine_config.options.theme = theme
    end

    lualine.setup(lualine_config)
end

Color.overrides = {
    catppuccin = function()
        require('catppuccin').setup({
            flavour = 'macchiato',
            background = 'dark',
        })
        vim.cmd('colorscheme catppuccin')
        setup_lualine('catppuccin')
    end,
    gruvbox = function()
        require('gruvbox').setup({
            overrides = {
                ['@type.qualifier'] = {
                    link = "Keyword"
                }
            }
        })
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd("colorscheme gruvbox")
        setup_lualine('gruvbox')
    end,
    melange = function()
        vim.cmd('colorscheme melange')
        setup_lualine('melange')
    end,
    rose_pine = function()
        require('rose-pine').setup({
            variant = 'moon'
        })
        vim.cmd('colorscheme rose-pine')
        setup_lualine('rose-pine')
    end,
    tokyonight = function()
        require('tokyonight').setup({
            style = 'moon',
        })
        vim.cmd('colorscheme tokyonight')
        setup_lualine('tokyonight')
    end,
}

---Changes the colorsheme
---@param color string
Color.change = function(color)
    if Color.overrides[color] ~= nil then
        Color.overrides[color]()
        return
    end

    vim.cmd('colorscheme ' .. color)
    setup_lualine(color)
end

vim.api.nvim_create_user_command('Color', function(data)
    Color.change(data.fargs[1])
end, {
    nargs = 1,
    complete = 'color'
})

return Color
