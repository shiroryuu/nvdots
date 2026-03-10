local M = {}

local get_icon = require("shiroryuu.utils.icon").get_unicon

function M.isRecording()
    return vim.fn.reg_recording() ~= ""
end

function M.recordingStatus()
    if not M.isRecording() then return "" end
    local icon = get_icon("General", "Recording", 1)
    local prefix = "@"
    local register = vim.fn.reg_recording()
    return  icon .. "Recording " .. prefix .. register
end

function M.notifyRecording()
    local icon = get_icon("General", "Recording", 1)
    local prefix = "@"
    local register = vim.fn.reg_recording()
    if M.isRecording() then
        vim.notify("Recording Macro " ..icon .. prefix .. register, vim.log.levels.INFO)
    end
end

-- Safe wrapper around snacks to prevent errors when LazyVim is still installing
function M.statuscolumn()
	return package.loaded.snacks and require("snacks.statuscolumn").get() or ""
end

return M
