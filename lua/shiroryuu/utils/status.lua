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

-- TODO: Add Recording notification

return M
