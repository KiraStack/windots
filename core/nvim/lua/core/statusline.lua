-- ╭──────────────────────────────────────────────────────────────╮
-- │                         Statusline                           │
-- │                      Adapted by KiraStacks                   │
-- │                   Credits: scottmckendry/Windots             │
-- ╰──────────────────────────────────────────────────────────────╯

local module = {}

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Constants                                                    │
-- ╰──────────────────────────────────────────────────────────────╯

-- Mode map for statusline_bg
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

-- Mode highlight groups map for statusline
local mode_hl_map = {
    ["NORMAL"] = "Directory",
    ["VISUAL"] = "Number",
    ["V-LINE"] = "Number",
    ["V-BLOCK"] = "Number",
    ["INSERT"] = "String",
    ["COMMAND"] = "Keyword",
    ["TERMINAL"] = "Keyword",
}

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Helpers                                                      │
-- ╰──────────────────────────────────────────────────────────────╯

-- Helper functions
-- Format a statusline segment with optional padding and highlight group
local function format(content, highlight_group, left_pad, right_pad)
    -- Check arguments
    assert(type(content) == "string", "content must be a string")

    -- Check if content is empty
    if content == "" then
        -- Return empty string
        return ""
    end

    -- Default values
    left_pad = left_pad or " "
    right_pad = right_pad or " "
    highlight_group = highlight_group or "Comment"

    -- Return formatted string
    return string.format("%s%%#%s#%s%%*%s", left_pad, highlight_group, content, right_pad)
end

-- Wrapper to call a module statusline function by name with an optional parameter
function _G.statusline_call(callback, param)
    return module[callback](param) -- Call statusline function
end

-- Generates a Vim statusline expression calling a module function with optional highlight
local function create(content, highlight_group)
    -- Check arguments
    assert(type(content) == "string" and content ~= "", "content must be a valid string")

    -- Call statusline function and return formatted string
    if highlight_group then
        return string.format("%%{%%v:lua.statusline_call('%s', '%s')%%}", content, highlight_group)
    else
        return string.format("%%{%%v:lua.statusline_call('%s')%%}", content)
    end
end

-- Counts and returns the number of listed, normal buffers currently loaded
function module.get_bufcnt()
    -- Get buffer count
    local count = 0
    local bufs = vim.api.nvim_list_bufs()

    -- Iterate over buffers
    for _, buf in ipairs(bufs) do
        local bufopts = vim.bo[buf] -- Get buffer options

        -- Check if buffer is valid
        if bufopts.buflisted and bufopts.buftype ~= "nofile" then
            count = count + 1
        end
    end

    -- Return buffer count
    return count
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Mode                                                         │
-- ╰──────────────────────────────────────────────────────────────╯

-- Returns the current editor mode as a formatted statusline component
function module.mode()
    -- Get current mode
    local mode_code = vim.api.nvim_get_mode().mode
    local mode_name = mode_map[mode_code]
    local highlight = mode_name and mode_hl_map[mode_name]

    -- Check if mode is valid
    if not mode_name then
        return ""
    end

    -- Return formatted string
    return format(" " .. string.lower(mode_name), highlight)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Git                                                          │
-- ╰──────────────────────────────────────────────────────────────╯

-- Returns the current Git branch formatted with an icon and optional highlight group.
function module.git_branch(highlight_group)
    -- Get current Git branch
    local branch = vim.g.gitsigns_head

    -- Check if branch is valid
    if not branch then
        return ""
    end

    -- Return formatted string
    return format(" " .. branch, highlight_group)
end

-- Returns Git diff summary with icons replacing +, -, ~ and optional highlight group.
function module.git_diff(highlight_group)
    -- Get Git difference summary status
    local status = vim.b.gitsigns_status

    -- Check if status is valid
    if not status or status == "" then
        return ""
    end

    -- Replace icons
    -- status = status
    --     :gsub("+", " ")
    --     :gsub("-", " ")
    --     :gsub("~", " ")

    -- Return formatted string
    return format(string.format('[%s]', status), highlight_group)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Diagnostics                                                  │
-- ╰──────────────────────────────────────────────────────────────╯

-- Returns a formatted string summarizing buffer diagnostics by severity
function module.diagnostics()
    -- Shorten diagnostic severity namespace
    local severity = vim.diagnostic.severity

    -- Severity counts
    local counts = {
        [severity.ERROR] = 0,
        [severity.WARN]  = 0,
        [severity.INFO]  = 0,
        [severity.HINT]  = 0,
    }

    -- Iterate over diagnostics
    for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
        counts[diagnostic.severity] = counts[diagnostic.severity] + 1
    end

    -- Check if there are any diagnostics
    if counts[severity.ERROR] + counts[severity.WARN] + counts[severity.INFO] + counts[severity.HINT] == 0 then
        return ""
    end

    -- Get icons and highlight groups
    local symbols = {
        [severity.ERROR] = { icon = "", hl = "DiagnosticError" },
        [severity.WARN]  = { icon = "", hl = "DiagnosticWarn" },
        [severity.INFO]  = { icon = "󰝶", hl = "DiagnosticInfo" },
        [severity.HINT]  = { icon = "", hl = "DiagnosticHint" },
    }

    local tokens = {} -- Parts of formatted string

    -- Iterate over severity counts
    for sev, cnt in pairs(counts) do
        -- Add severity count if greater than zero
        if cnt > 0 then
            tokens[#tokens + 1] = format(string.format('%s %s', symbols[sev].icon, cnt), symbols[sev].hl)
        end
    end

    -- Return formatted string
    return (#tokens > 0) and table.concat(tokens) or ""
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Breadcrumbs                                                  │
-- ╰──────────────────────────────────────────────────────────────╯

-- Returns current location from nvim-navic if available and attached
function module.navic(highlight_group)
    -- Check if nvim-navic is available
    if not package.loaded["nvim-navic"] or not require("nvim-navic").is_available() then
        return ""
    end

    -- Return formatted string of current location
    return format(require("nvim-navic").get_location(), highlight_group)
end

-- Returns formatted lazy.nvim update status if available
function module.lazy_updates(highlight_group)
    -- Get updates
    local updates = require("lazy.status").updates()

    -- Check if updates are available
    if type(updates) ~= "string" then
        return ""
    end

    -- Return formatted string
    return format(updates, highlight_group)
end

-- Returns formatted search count for current search if active and valid
function module.search_count(highlight_group)
    -- Check if search is active
    if vim.v.hlsearch == 0 then
        return ""
    end

    -- Get search count
    local status, cnt = pcall(vim.fn.searchcount, { recompute = true })
    if not status or not cnt.current or cnt.total == 0 then
        return ""
    end

    -- Check if search is incomplete
    if cnt.incomplete == 1 then
        return format("?/?", highlight_group)
    end

    -- Return formatted string
    return format(cnt.current .. "/" .. cnt.total, highlight_group) -- Search is complete
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ File                                                         │
-- ╰──────────────────────────────────────────────────────────────╯

-- Returns formatted file name with icon and highlights, applying overrides for filetypes and filenames
function module.file_name(highlight_group)
    -- Define filetype overrides with set properties
    local ft_overrides = {
        ["copilot-chat"] = { name = "copilot", icon = "󰚩", icon_hl = "MiniIconsAzure" },
        ["grug-far"] = { name = "grug-far", icon = "", icon_hl = "DiagnosticWarn" },
        ["lazy"] = { name = "lazy.nvim", icon = "󰒲", icon_hl = "Directory" },
        ["mason"] = { name = "mason", icon = "󱌣", icon_hl = "MiniIconsAzure" },
        ["minifiles"] = { name = "files", icon = "󰝰", icon_hl = "Directory" },
        ["snacks_picker_input"] = { name = "picker", icon = "󰦨", icon_hl = "Changed" },
    }
    -- Define filename overrides with set properties
    local fn_overrides = {
        ["k9s"] = { icon = "󱃾", icon_hl = "Directory" },
        ["lazygit"] = { icon = "", icon_hl = "Changed" },
    }

    -- Check if current buffer is valid
    if ft_overrides[vim.bo.filetype] then
        local opt = ft_overrides[vim.bo.filetype]                                 -- Get filetype override
        return format(opt.icon, opt.icon_hl) .. format(opt.name, highlight_group) -- Return formatted string
    end

    -- Get the current buffer's file name
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")

    -- Check if name is empty
    if name == "" then
        -- Return empty string if name is empty
        return ""
    end

    -- Get respective icon and highlight group
    local icon, icon_hl = require("mini.icons").get("file", name)

    -- Check if icon override is available
    if fn_overrides[name] then
        -- Get icon override
        icon, icon_hl = fn_overrides[name].icon, fn_overrides[name].icon_hl
    end

    -- Return formatted string
    return format(icon, highlight_group) .. format(name, highlight_group)
    -- previous value: format(icon, icon_hl) .. format(name, highlight_group)
end

-- Returns formatted count of other listed buffers excluding current buffer
function module.other_buffers(highlight_group)
    -- Get buffer count excluding current buffer
    local bufcnt = module.get_bufcnt() - 1

    -- Check if there are any other buffers
    if bufcnt <= 0 then
        return ""
    end

    -- Return formatted string of buffer count
    return format(string.format("+%d ", bufcnt), highlight_group)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Progress                                                     │
-- ╰──────────────────────────────────────────────────────────────╯


-- Line:column position create with file encoding and file format
function module.progress(highlight_group)
    return format("%2p%%", highlight_group)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Location                                                     │
-- ╰──────────────────────────────────────────────────────────────╯

-- Line:column position create with file encoding and file format
function module.location(highlight_group)
    return format("%l:%c", highlight_group)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Clock                                                        │
-- ╰──────────────────────────────────────────────────────────────╯

-- Clock create with time in 12-hour formatted time with AM/PM
function module.clock(highlight_group)
    return format(os.date("%I:%M %p"):gsub("^0", ""), highlight_group)
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Statusline                                                   │
-- ╰──────────────────────────────────────────────────────────────╯

module.statusline = table.concat({
    -- Left-side creates
    create("mode"),                     -- Current Vim mode
    create("git_branch", "Changed"),    -- Git branch
    create("file_name", "Normal"),      -- Filename with icon
    create("git_diff", "Type"),         -- Git changes
    create("other_buffers", "Comment"), -- Other buffer count
    -- create("lazy_updates", "String"),   -- Lazy updates
    create("diagnostics"),              -- LSP diagnostics
    -- create("navic", "Comment"),         -- LSP context

    -- Right-side creates
    "%=",                          -- Right align
    -- create("search_count", "Directory"), -- Search count
    create("progress", "Special"), -- Percentage through file
    create("location", "Changed"), -- Line:column position
    create("clock", "Conceal")     -- Current time
}, "")

return module
