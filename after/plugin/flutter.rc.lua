local status, flutterTools = pcall(require, "flutter-tools")
if (not status) then return end

flutterTools.setup({})
-- nvim.api.nvim_set_keymap('n', '<Leader>fr', :'FlutterRun', { noremap= true, slient = true})
