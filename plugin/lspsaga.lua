local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
    server_filetype_map = {
        typescript = "typescript"
    },
    request_timeout = 5000,
})

local keymap = vim.keymap.set

-- local opts = { noremap = true, silent = true }
keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
keymap('n', 'gd', '<Cmd>Lspsaga finder<CR>')
keymap('n', '<C-space>', '<cmd>Lspsaga code_action<CR>')
keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>')
keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>')
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>')
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
-- Floating terminal
keymap("n", "gt", "<cmd>Lspsaga term_toggle<CR>")
