---@class KnownFolders
---@field home string
---@field documents string
---@field pictures string
---@field music string
---@field videos string
---@field desktop string
---@field downloads string
---@field public string
---@field fonts string
---@field app_menu string
---@field cache string
---@field roaming_configuration string
---@field local_configuration string
---@field global_configuration string
---@field data string
---@field logs string
---@field runtime string

---@class AllKnownFolders
---@field mac KnownFolders
---@field unix KnownFolders
---@field win32 KnownFolders

---@class SetupOpts
---@field known_folders AllKnownFolders
---@field xdg boolean

local mac = vim.fn.has('mac')
local unix = vim.fn.has('unix')
local win32 = vim.fn.has('win32')

local home_dir = nil
local documents_dir = nil
local pictures_dir = nil
local music_dir = nil
local videos_dir = nil
local desktop_dir = nil
local downloads_dir = nil
local public_dir = nil
local fonts_dir = nil
local app_menu_dir = nil
local cache_dir = nil
local roaming_configuration_dir = nil
local local_configuration_dir = nil
local global_configuration_dir = nil
local data_dir = nil
local logs_dir = nil
local runtime_dir = nil

---@type KnownFolders
local unix_xdg = {
    home = '$HOME',
    documents = '$XDG_DOCUMENTS_DIR',
    pictures = '$XDG_PICTURES_DIR',
    music = '$XDG_MUSIC_DIR',
    videos = '$XDG_VIDEOS_DIR',
    desktop = '$XDG_DESKTOP_DIR',
    downloads = '$XDG_DOWNLOADS_DIR',
    public = '$XDG_PUBLICSHARE_DIR',
    fonts = '$XDG_DATA_HOME/fonts',
    app_menu = '$XDG_DATA_HOME/applications',
    cache = '$HOME/.cache',
    roaming_configuration = '$XDG_CONFIG_HOME',
    local_configuration = '$XDG_CONFIG_DIRS',
    global_configuration = '/etc',
    data = '$XDG_DATA_HOME',
    logs = '$XDG_STATE_HOME',
    runtime = '$XDG_RUNTIME_DIR',
}

---@type SetupOpts
local default_opts = {
    known_folders = {
        unix = {
            home = '$HOME',
            documents = '$HOME/Documents',
            pictures = '$HOME/Pictures',
            music = '$HOME/Music',
            videos = '$HOME/Videos',
            desktop = '$HOME/Desktop',
            downloads = '$HOME/Downloads',
            public = '$HOME/Public',
            fonts = '$HOME/.local/share/fonts',
            app_menu = '$HOME/.local/share/applications',
            cache = '$HOME/.cache',
            roaming_configuration = '$HOME/.config',
            local_configuration = '$HOME/.config',
            global_configuration = '/etc',
            data = '$HOME/.local/share',
            logs = '$HOME/.local/state',
            runtime = '$XDG_RUNTIME_DIR',
        },
        mac = {
            home = '$HOME',
            documents = '$HOME/Documents',
            pictures = '$HOME/Pictures',
            music = '$HOME/Music',
            videos = '$HOME/Movies',
            desktop = '$HOME/Desktop',
            downloads = '$HOME/Downloads',
            public = '$HOME/Public',
            fonts = '$HOME/Library/Fonts',
            app_menu = '$HOME/Applications',
            cache = '$HOME/Library/Caches',
            roaming_configuration = '$HOME/Library/Preferences',
            local_configuration = '$HOME/Library/Application Support',
            global_configuration = '/Library/Preferences',
            data = '$HOME/Library/Application Support',
            logs = '$HOME/Library/Logs',
            runtime = '$HOME/Library/Application Support',
        },
        win32 = {
            home = '%USERPROFILE%',
            documents = '%USERPROFILE%/Documents',
            pictures = '%USERPROFILE%/Pictures',
            music = '%USERPROFILE%/Music',
            videos = '%USERPROFILE%/Videos',
            desktop = '%USERPROFILE%/Desktop',
            downloads = '%USERPROFILE%/Downloads',
            public = '%USERPROFILE%/Public',
            fonts = '%windir%/Fonts',
            app_menu = '%APPDATA%/Microsoft/Windows/Start Menu',
            cache = '%LOCALAPPDATA%/Temp',
            roaming_configuration = '%APPDATA%',
            local_configuration = '%LOCALAPPDATA%',
            global_configuration = '%ALLUSERSPROFILE%',
            data = '%LOCALAPPDATA%/Temp',
            logs = '%LOCALAPPDATA%/Temp',
            runtime = '%LOCALAPPDATA%/Temp',
        },
    },
    xdg = false,
}

local M = {
    ---@param opts SetupOpts|nil
    setup = function(opts)
        opts = opts or default_opts

        if opts.xdg then
            opts.known_folders.unix = unix_xdg
        end

        opts = vim.tbl_deep_extend('force', default_opts, opts)

        ---@type KnownFolders
        local known_folders = assert(
            (unix and opts.known_folders.unix) or
            (mac and opts.known_folders.mac) or
            (win32 and opts.known_folders.win32) or
            nil
        )

        home_dir = vim.fs.normalize(known_folders.home)
        documents_dir = vim.fs.normalize(known_folders.documents)
        pictures_dir = vim.fs.normalize(known_folders.pictures)
        music_dir = vim.fs.normalize(known_folders.music)
        videos_dir = vim.fs.normalize(known_folders.videos)
        desktop_dir = vim.fs.normalize(known_folders.desktop)
        downloads_dir = vim.fs.normalize(known_folders.downloads)
        public_dir = vim.fs.normalize(known_folders.public)
        fonts_dir = vim.fs.normalize(known_folders.fonts)
        app_menu_dir = vim.fs.normalize(known_folders.app_menu)
        cache_dir = vim.fs.normalize(known_folders.cache)
        roaming_configuration_dir = vim.fs.normalize(known_folders.roaming_configuration)
        local_configuration_dir = vim.fs.normalize(known_folders.local_configuration)
        global_configuration_dir = vim.fs.normalize(known_folders.global_configuration)
        data_dir = vim.fs.normalize(known_folders.data)
        logs_dir = vim.fs.normalize(known_folders.logs)
        runtime_dir = vim.fs.normalize(known_folders.runtime)
    end,

    ---@return string
    home = function()
        return assert(home_dir)
    end,

    ---@return string
    documents = function()
        return assert(documents_dir)
    end,

    ---@return string
    pictures = function()
        return assert(pictures_dir)
    end,

    ---@return string
    music = function()
        return assert(music_dir)
    end,

    ---@return string
    videos = function()
        return assert(videos_dir)
    end,

    ---@return string
    desktop = function()
        return assert(desktop_dir)
    end,

    ---@return string
    downloads = function()
        return assert(downloads_dir)
    end,

    ---@return string
    public = function()
        return assert(public_dir)
    end,

    ---@return string
    fonts = function()
        return assert(fonts_dir)
    end,

    ---@return string
    app_menu = function()
        return assert(app_menu_dir)
    end,

    ---@return string
    cache = function()
        return assert(cache_dir)
    end,

    ---@return string
    roaming_configuration = function()
        return assert(roaming_configuration_dir)
    end,

    ---@return string
    local_configuration = function()
        return assert(local_configuration_dir)
    end,

    ---@return string
    global_configuration = function()
        return assert(global_configuration_dir)
    end,

    ---@return string
    data = function()
        return assert(data_dir)
    end,

    ---@return string
    logs = function()
        return assert(logs_dir)
    end,

    ---@return string
    runtime = function()
        return assert(runtime_dir)
    end,
}

return assert(M)
