local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- saga.init_lsp_saga {
--     finder_request_timeout = 5000,
-- }

saga.setup({

    preview = {
        lines_above = 0,
        lines_below = 10,
    },
    scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
    request_timeout = 5000,
})

local keymap = vim.keymap.set

-- local opts = { noremap = true, silent = true }
keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>')
keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>')
keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>')
keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>')
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>')
