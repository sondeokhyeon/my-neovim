local actions = require("diffview.actions")
local status, dv = pcall(require,"diffview")

if (not status) then return end

dv.setup({})

