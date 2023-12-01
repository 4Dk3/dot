-- Keybindings for save with control + s and exit and save with control + x
local keymap = vim.api.nvim_set_keymap
     keymap("n", "<c-s>", ":w<CR>", {})
     keymap("i", "<c-s>", "<ESC>:w<CR>a", {})
     keymap("n", "<c-x>", ":x<CR>", {})
     keymap("i", "<c-x>", "<ESC>:x<CR>a", {})
     keymap("n", "<c-f>", ":NvimTreeToggle<CR>", {})
     keymap("i", "<c-f>", "<ESC>:NvimTreeToggle<CR>a", {})


local opts = { noremap = true }
     keymap("n", "<c-j>", "<c-w>j", opts)
     keymap("n", "<c-h>", "<c-w>h", opts)
     keymap("n", "<c-k>", "<c-w>k", opts)
     keymap("n", "<c-l>", "<c-w>l", opts)
