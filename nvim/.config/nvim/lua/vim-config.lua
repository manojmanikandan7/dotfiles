vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")


vim.cmd("set ignorecase") -- ignore case when searching
vim.cmd("set smartcase") -- if you include mixed case in your search, assumes you want case-sensitive
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.opt.clipboard:append("unnamedplus")

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.cmd("set termguicolors")
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes"-- show sign column so that text doesn't shift

-- backspace
vim.opt.backspace = "indent,eol,start"-- allow backspace on indent, end of line or insert mode start position


-- split windows
vim.cmd("set splitright")
vim.cmd("set splitbelow")

-- turn off swapfile

vim.opt.swapfile = false

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
