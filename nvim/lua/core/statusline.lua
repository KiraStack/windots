-- ╭──────────────────────────────────────────────────────────────╮
-- │                         Statusline                           │
-- │                      Adapted by KiraStacks                   │
-- │                   Credits: scottmckendry/Windots             │
-- ╰──────────────────────────────────────────────────────────────╯

local module = {}

--  __    __  ________  __        _______   ________  _______    ______
-- |  \  |  \|        \|  \      |       \ |        \|       \  /      \
-- | $$  | $$| $$$$$$$$| $$      | $$$$$$$\| $$$$$$$$| $$$$$$$\|  $$$$$$\
-- | $$__| $$| $$__    | $$      | $$__/ $$| $$__    | $$__| $$| $$___\$$
-- | $$    $$| $$  \   | $$      | $$    $$| $$  \   | $$    $$ \$$    \
-- | $$$$$$$$| $$$$$   | $$      | $$$$$$$ | $$$$$   | $$$$$$$\ _\$$$$$$\
-- | $$  | $$| $$_____ | $$_____ | $$      | $$_____ | $$  | $$|  \__| $$
-- | $$  | $$| $$     \| $$     \| $$      | $$     \| $$  | $$ \$$    $$
--  \$$   \$$ \$$$$$$$$ \$$$$$$$$ \$$       \$$$$$$$$ \$$   \$$  \$$$$$$

-- Helper functions
local function format_component(content, highighlight_groupight_group, left_pad, right_pad)
    left_pad = left_pad or " "
    right_pad = right_pad or " "
    highighlight_groupight_group = highighlight_groupight_group or "Comment"
    return string.format("%s%%#%s#%s%%*%s", left_pad, highighlight_groupight_group, content, right_pad)
end

local function component(val, highlight_group)
    if val == nil or val == "" then return "" end
    if highlight_group == nil then
        return "%{%v:lua._statusline_component('" .. val .. "')%}"
    end
    return "%{%v:lua._statusline_component('" .. val .. "', '" .. highlight_group .. "')%}"
end

-- Components
local mode_map = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["i"] = "INSERT",
    ["c"] = "COMMAND",
    ["r"] = "REPLACE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
    ["nt"] = "TERMINAL",
}

local mode_highlight_group_map = {
    ["NORMAL"] = "Directory",
    ["VISUAL"] = "Number",
    ["V-LINE"] = "Number",
    ["V-BLOCK"] = "Number",
    ["INSERT"] = "String",
    ["COMMAND"] = "Keyword",
    ["TERMINAL"] = "Keyword",
}

function _G._statusline_component(name, highlight_group)
    return module[name](highlight_group)
end

function module.get_highlight_groupgroup(name, fallback)
    if vim.fn.highlight_groupexists(name) == 1 then
        local group = vim.api.nvim_get_highlight_group(0, { name = name })
        local highlight_group = {
            fg = group.fg == nil and "NONE" or string.format("#%x", group.fg),
            bg = group.bg == nil and "NONE" or string.format("#%x", group.bg),
        }
        return highlight_group
    end
    return fallback or {}
end

function module.get_buffer_count()
    local count = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted and vim.bo[buf].buftype ~= "nofile" then
            count = count + 1
        end
    end
    return count
end

function module.switch_to_other_buffer()
    if pcall(vim.cmd, "buffer #") then return end
    if module.get_buffer_count() > 1 then return vim.cmd("bprevious") end
    vim.notify("No other buffer to switch to!", 3, { title = "Warning" })
end

function module.open_help(buf)
    if buf ~= nil and vim.bo[buf].filetype == "help" and not vim.bo[buf].modifiable then
        local help_win = vim.api.nvim_get_current_win()
        local new_win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            row = 0,
            col = vim.o.columns - 80,
            width = 80,
            height = vim.o.lines - 3,
            border = "rounded",
        })
        vim.wo[help_win].scroll = vim.wo[new_win].scroll
        vim.api.nvim_win_close(help_win, true)
    end
end

function module.write_to_file(file, lines)
    if not lines or #lines == 0 then return end
    local buf = io.open(file, "w")
    if buf then
        for _, line in ipairs(lines) do buf:write(line .. "\n") end
        buf:close()
    end
end

function module.toggle_global_boolean(option, description)
    return require("snacks").toggle({
        name = description,
        get = function() return vim.g[option] == nil or vim.g[option] end,
        set = function(state) vim.g[option] = state end,
    })
end

function module.open_terminal_toggle(cmd, fullscreen)
    local opts = fullscreen and { win = { position = "float", width = 0.99, height = 0.99 } } or nil
    require("snacks").terminal.toggle(cmd, opts)
    if vim.bo.filetype == "snacks_terminal" then
        vim.notify("_Double press `ESC`_ to return to normal mode", 2, { title = cmd[1] })
    end
end

--  __       __   ______   _______   ________
-- |  \     /  \ /      \ |       \ |        \
-- | $$\   /  $$|  $$$$$$\| $$$$$$$\| $$$$$$$$
-- | $$$\ /  $$$| $$  | $$| $$  | $$| $$__
-- | $$$$\  $$$$| $$  | $$| $$  | $$| $$  \
-- | $$\$$ $$ $$| $$  | $$| $$  | $$| $$$$$
-- | $$ \$$$| $$| $$__/ $$| $$__/ $$| $$_____
-- | $$  \$ | $$ \$$    $$| $$    $$| $$     \
--  \$$      \$$  \$$$$$$  \$$$$$$$  \$$$$$$$$

-- Statusline components
local function get_mode_info()
    local mode = vim.api.nvim_get_mode().mode
    local val = mode_map[mode]
    return val, mode_highlight_group_map[val]
end

function module.mode()
    local val, highlight_group = get_mode_info()
    return val and format_component(" " .. string.lower(val), highlight_group) or ""
end

--   ______   ______  ________
--  /      \ |      \|        \
-- |  $$$$$$\ \$$$$$$ \$$$$$$$$
-- | $$ __\$$  | $$     | $$
-- | $$|    \  | $$     | $$
-- | $$ \$$$$  | $$     | $$
-- | $$__| $$ _| $$_    | $$
--  \$$    $$|   $$ \   | $$
--   \$$$$$$  \$$$$$$    \$$

function module.git_branch(highlight_group)
    local branch = vim.g.gitsigns_head
    return branch and format_component(" " .. branch, highlight_group) or ""
end

function module.git_diff(highlight_group)
    local summary = vim.b.gitsigns_status
    if not summary or summary == "" then return "" end
    return format_component(summary:gsub("+", " "):gsub("-", " "):gsub("~", " "), highlight_group)
end

--  __       __   ______   _______   __    __  ______  __    __   ______
-- |  \  _  |  \ /      \ |       \ |  \  |  \|      \|  \  |  \ /      \
-- | $$ / \ | $$|  $$$$$$\| $$$$$$$\| $$\ | $$ \$$$$$$| $$\ | $$|  $$$$$$\
-- | $$/  $\| $$| $$__| $$| $$__| $$| $$$\| $$  | $$  | $$$\| $$| $$ __\$$
-- | $$  $$$\ $$| $$    $$| $$    $$| $$$$\ $$  | $$  | $$$$\ $$| $$|    \
-- | $$ $$\$$\$$| $$$$$$$$| $$$$$$$\| $$\$$ $$  | $$  | $$\$$ $$| $$ \$$$$
-- | $$$$  \$$$$| $$  | $$| $$  | $$| $$ \$$$$ _| $$_ | $$ \$$$$| $$__| $$
-- | $$$    \$$$| $$  | $$| $$  | $$| $$  \$$$|   $$ \| $$  \$$$ \$$    $$
--  \$$      \$$ \$$   \$$ \$$   \$$ \$$   \$$ \$$$$$$ \$$   \$$  \$$$$$$


function module.diagnostics()
    local diag_severity = vim.diagnostic.severity
    local counts = {
        [diag_severity.ERROR] = 0,
        [diag_severity.WARN] = 0,
        [diag_severity.INFO] = 0,
        [diag_severity.HINT] = 0,
    }

    -- Get counts for each severity level
    for _, diag in ipairs(vim.diagnostic.get(0)) do
        counts[diag.severity] = (counts[diag.severity] or 0) + 1
    end

    -- Only show if there are diagnostics
    if counts[diag_severity.ERROR] + counts[diag_severity.WARN] +
        counts[diag_severity.INFO] + counts[diag_severity.HINT] == 0 then
        return ""
    end

    -- Build components
    local components = {
        counts[diag_severity.ERROR] > 0 and
        format_component(" " .. counts[diag_severity.ERROR], "DiagnosticError", "") or "",
        counts[diag_severity.WARN] > 0 and
        format_component(" " .. counts[diag_severity.WARN], "DiagnosticWarn", "") or "",
        counts[diag_severity.INFO] > 0 and
        format_component("󰝶 " .. counts[diag_severity.INFO], "DiagnosticInfo", "") or "",
        counts[diag_severity.HINT] > 0 and
        format_component(" " .. counts[diag_severity.HINT], "DiagnosticHint", "") or "",
    }

    return " " .. table.concat(components, "") .. " "
end

--  _______   _______   ________   ______   _______    ______   __    __  __       __  _______    ______
-- |       \ |       \ |        \ /      \ |       \  /      \ |  \  |  \|  \     /  \|       \  /      \
-- | $$$$$$$\| $$$$$$$\| $$$$$$$$|  $$$$$$\| $$$$$$$\|  $$$$$$\| $$  | $$| $$\   /  $$| $$$$$$$\|  $$$$$$\
-- | $$__/ $$| $$__| $$| $$__    | $$__| $$| $$  | $$| $$   \$$| $$  | $$| $$$\ /  $$$| $$__/ $$| $$___\$$
-- | $$    $$| $$    $$| $$  \   | $$    $$| $$  | $$| $$      | $$  | $$| $$$$\  $$$$| $$    $$ \$$    \
-- | $$$$$$$\| $$$$$$$\| $$$$$   | $$$$$$$$| $$  | $$| $$   __ | $$  | $$| $$\$$ $$ $$| $$$$$$$\ _\$$$$$$\
-- | $$__/ $$| $$  | $$| $$_____ | $$  | $$| $$__/ $$| $$__/  \| $$__/ $$| $$ \$$$| $$| $$__/ $$|  \__| $$
-- | $$    $$| $$  | $$| $$     \| $$  | $$| $$    $$ \$$    $$ \$$    $$| $$  \$ | $$| $$    $$ \$$    $$
--  \$$$$$$$  \$$   \$$ \$$$$$$$$ \$$   \$$ \$$$$$$$   \$$$$$$   \$$$$$$  \$$      \$$ \$$$$$$$   \$$$$$$


function module.navic(highlight_group)
    if package.loaded["nvim-navic"] and require("nvim-navic").is_available() then
        return format_component(require("nvim-navic").get_location(), highlight_group)
    end
    return ""
end

function module.status_messages(highlight_group)
    local ignore = { "-- INSERT --", "-- TERMINAL --", "-- VISUAL --", "-- VISUAL LINE --", "-- VISUAL BLOCK --" }
    if require("noice").api.status.mode.has() then
        local mode = require("noice").api.status.mode.get()
        if not vim.tbl_contains(ignore, mode) then
            return format_component(mode, highlight_group)
        end
    end
    return ""
end

function module.lazy_updates(highlight_group)
    local updates = require("lazy.status").updates()
    return type(updates) == "string" and format_component(updates, highlight_group) or ""
end

function module.search_count(highlight_group)
    if vim.v.highlight_groupsearch == 0 then return "" end
    local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
    if not ok or s_count.current == nil or s_count.total == 0 then return "" end
    return format_component(s_count.incomplete == 1 and "?/?" or s_count.current .. "/" .. s_count.total, highlight_group)
end

--  ________  ______  __        ________
-- |        \|      \|  \      |        \
-- | $$$$$$$$ \$$$$$$| $$      | $$$$$$$$
-- | $$__      | $$  | $$      | $$__
-- | $$  \     | $$  | $$      | $$  \
-- | $$$$$     | $$  | $$      | $$$$$
-- | $$       _| $$_ | $$_____ | $$_____
-- | $$      |   $$ \| $$     \| $$     \
--  \$$       \$$$$$$ \$$$$$$$$ \$$$$$$$$

function module.file_name(highlight_group)
    local ft_overrides = {
        ["copilot-chat"] = { name = "copilot", icon = "󰚩", icon_highlight_group = "MiniIconsAzure" },
        ["grug-far"] = { name = "grug-far", icon = "", icon_highlight_group = "DiagnosticWarn" },
        ["lazy"] = { name = "lazy.nvim", icon = "󰒲", icon_highlight_group = "Directory" },
        ["mason"] = { name = "mason", icon = "󱌣", icon_highlight_group = "MiniIconsAzure" },
        ["minifiles"] = { name = "files", icon = "󰝰", icon_highlight_group = "Directory" },
        ["snacks_picker_input"] = { name = "picker", icon = "󰦨", icon_highlight_group = "Changed" },
    }

    local fn_overrides = {
        ["k9s"] = { icon = "󱃾", icon_highlight_group = "Directory" },
        ["lazygit"] = { icon = "", icon_highlight_group = "Changed" },
    }

    local ft = vim.bo.filetype
    if ft_overrides[ft] then
        return format_component(ft_overrides[ft].icon, ft_overrides[ft].icon_highlight_group, " ", "")
            .. format_component(ft_overrides[ft].name, highlight_group)
    end

    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
    if filename == "" then return "" end

    local icon, icon_highlight_group = require("mini.icons").get("file", filename)
    if fn_overrides[filename] then
        icon, icon_highlight_group = fn_overrides[filename].icon, fn_overrides[filename].icon_highlight_group
    end

    return format_component(icon, icon_highlight_group, " ", "") .. format_component(filename, highlight_group)
end

function module.other_buffers(highlight_group)
    local other_bufs = module.get_buffer_count() - 1
    return other_bufs > 0 and format_component("+" .. other_bufs .. " ", highlight_group, "", " ") or ""
end

--  _______   _______    ______    ______   _______   ________   ______    ______
-- |       \ |       \  /      \  /      \ |       \ |        \ /      \  /      \
-- | $$$$$$$\| $$$$$$$\|  $$$$$$\|  $$$$$$\| $$$$$$$\| $$$$$$$$|  $$$$$$\|  $$$$$$\
-- | $$__/ $$| $$__| $$| $$  | $$| $$ __\$$| $$__| $$| $$__    | $$___\$$| $$___\$$
-- | $$    $$| $$    $$| $$  | $$| $$|    \| $$    $$| $$  \    \$$    \  \$$    \
-- | $$$$$$$ | $$$$$$$\| $$  | $$| $$ \$$$$| $$$$$$$\| $$$$$    _\$$$$$$\ _\$$$$$$\
-- | $$      | $$  | $$| $$__/ $$| $$__| $$| $$  | $$| $$_____ |  \__| $$|  \__| $$
-- | $$      | $$  | $$ \$$    $$ \$$    $$| $$  | $$| $$     \ \$$    $$ \$$    $$
--  \$$       \$$   \$$  \$$$$$$   \$$$$$$  \$$   \$$ \$$$$$$$$  \$$$$$$   \$$$$$$



-- Line:column position component with file encoding and file format
function module.progress(highlight_group)
    return format_component("%2p%%", highlight_group)
end

--  __        ______    ______    ______  ________  ______   ______   __    __
-- |  \      /      \  /      \  /      \|        \|      \ /      \ |  \  |  \
-- | $$     |  $$$$$$\|  $$$$$$\|  $$$$$$\\$$$$$$$$ \$$$$$$|  $$$$$$\| $$\ | $$
-- | $$     | $$  | $$| $$   \$$| $$__| $$  | $$     | $$  | $$  | $$| $$$\| $$
-- | $$     | $$  | $$| $$      | $$    $$  | $$     | $$  | $$  | $$| $$$$\ $$
-- | $$     | $$  | $$| $$   __ | $$$$$$$$  | $$     | $$  | $$  | $$| $$\$$ $$
-- | $$_____| $$__/ $$| $$__/  \| $$  | $$  | $$    _| $$_ | $$__/ $$| $$ \$$$$
-- | $$     \\$$    $$ \$$    $$| $$  | $$  | $$   |   $$ \ \$$    $$| $$  \$$$
--  \$$$$$$$$ \$$$$$$   \$$$$$$  \$$   \$$   \$$    \$$$$$$  \$$$$$$  \$$   \$$

-- Line:column position component with file encoding and file format
function module.location(highlight_group)
    return format_component("%l:%c", highlight_group)
end

--   ______   __        ______    ______   __    __
--  /      \ |  \      /      \  /      \ |  \  /  \
-- |  $$$$$$\| $$     |  $$$$$$\|  $$$$$$\| $$ /  $$
-- | $$   \$$| $$     | $$  | $$| $$   \$$| $$/  $$
-- | $$      | $$     | $$  | $$| $$      | $$  $$
-- | $$   __ | $$     | $$  | $$| $$   __ | $$$$$\
-- | $$__/  \| $$_____| $$__/ $$| $$__/  \| $$ \$$\
--  \$$    $$| $$     \\$$    $$ \$$    $$| $$  \$$\
--   \$$$$$$  \$$$$$$$$ \$$$$$$   \$$$$$$  \$$   \$$

-- Clock component with time in 12-hour formatted time with AM/PM
function module.clock(highlight_group)
    return format_component(os.date("%I:%M %p"):gsub("^0", ""), highlight_group)
end

--   ______  ________   ______  ________  __    __  ________   ______
--  /      \|        \ /      \|        \|  \  |  \|        \ /      \
-- |  $$$$$$\\$$$$$$$$|  $$$$$$\\$$$$$$$$| $$  | $$| $$$$$$$$|  $$$$$$\
-- | $$___\$$  | $$   | $$__| $$  | $$   | $$  | $$| $$__    | $$___\$$
--  \$$    \   | $$   | $$    $$  | $$   | $$  | $$| $$  \    \$$    \
--  _\$$$$$$\  | $$   | $$$$$$$$  | $$   | $$  | $$| $$$$$    _\$$$$$$\
-- |  \__| $$  | $$   | $$  | $$  | $$   | $$__/ $$| $$_____ |  \__| $$
--  \$$    $$  | $$   | $$  | $$  | $$    \$$    $$| $$     \ \$$    $$
--   \$$$$$$    \$$    \$$   \$$   \$$     \$$$$$$  \$$$$$$$$  \$$$$$$

module.statusline = table.concat({
    -- Left side components
    component("mode"),                  -- Current Vim mode
    component("git_branch", "Changed"), -- Git branch
    component("git_diff", "Type"),      -- Git changes
    component("diagnostics"),           -- LSP diagnostics
    component("navic", "Comment"),      -- LSP context
    "%<",                               -- Truncation point

    -- Right side components
    "%=",                                   -- Right align
    component("lazy_updates", "String"),    -- Lazy updates
    component("search_count", "Directory"), -- Search count
    component("file_name", "Normal"),       -- Filename with icon
    component("other_buffers", "Comment"),  -- Other buffer count
    component("progress", "Special"),       -- Percentage through file
    component("location", "Changed"),       -- Line:column position
    component("clock", "Conceal")           -- Current time
}, "")

return module
