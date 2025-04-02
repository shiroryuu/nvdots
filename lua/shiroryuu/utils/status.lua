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
    return  "Recording " .. icon .. prefix .. register
end

-- DONE: Add Recording notification
function M.notifyRecording()
    local icon = get_icon("General", "Recording", 1)
    local prefix = "@"
    local register = vim.fn.reg_recording()
    if M.isRecording() then
        vim.notify("Recording Macro " ..icon .. prefix .. register, vim.log.levels.INFO)
    end
end

return M
