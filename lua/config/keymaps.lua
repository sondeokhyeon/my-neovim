-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- number Toggle
keymap.set("n", "<Leader>n[", ":set number norelativenumber")
keymap.set("n", "<Leader>n]", ":set number relativenumber")

-- Quit
keymap.set("n", "qq", "<CMD>q<CR>")

-- Formatting
keymap.set("n", "FF", "<CMD>lua vim.lsp.buf.format()<CR>")

-- Diagnostics
-- keymap.set("n", "<C-j>", function()
--   vim.diagnostic.goto_next()
-- end, opts)

-- gitBlameLine
keymap.set("n", "gl", "<Cmd>GitBlameLineToggle<CR>")

-- tab split definition
keymap.set("n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)

-- lineMove
keymap.set("n", "<C-k>", ":m .-2<CR>==") -- move line down(n)
keymap.set("n", "<C-j>", ":m .+1<CR>==") -- move line up(n)
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- tmux move
keymap.set("n", "sk", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap.set("n", "sj", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap.set("n", "sh", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap.set("n", "sl", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
