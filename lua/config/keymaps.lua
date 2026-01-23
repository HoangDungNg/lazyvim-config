-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- NeoTree keymaps
-- NeoTree filesystem
vim.keymap.set("n", "<leader>e", function()
  require("neo-tree.command").execute({ source = "filesystem", toggle = true, position = "left" })
end, { desc = "NeoTree: Files" })

-- NeoTree buffers
-- vim.keymap.set("n", "<leader>Nb", function()
--   require("neo-tree.command").execute({ source = "buffers", toggle = true, position = "left" })
-- end, { desc = "NeoTree: Buffers" })
--
-- -- NeoTree Git status
-- vim.keymap.set("n", "<leader>Ng", function()
--   require("neo-tree.command").execute({ source = "git_status", toggle = true, position = "left" })
-- end, { desc = "NeoTree: Git Status" })
--
-- -- Close NeoTree
-- vim.keymap.set("n", "<leader>Nq", function()
--   vim.cmd("Neotree close")
-- end, { desc = "NeoTree: Close" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save buffer
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })
-- Close buffer without saving
vim.keymap.set("n", "<C-q>", ":bd!<CR>", { desc = "Close buffer without saving" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader>tp", ":tabprev<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader>te", ":tabedit<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" })

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "sj", "<C-w>j")

-- Resize window using Alt + arrow keys
vim.keymap.set("n", "<M-Left>", "<C-w><", { desc = "Resize window left" })
vim.keymap.set("n", "<M-Right>", "<C-w>>", { desc = "Resize window right" })
vim.keymap.set("n", "<M-Up>", "<C-w>+", { desc = "Resize window up" })
vim.keymap.set("n", "<M-Down>", "<C-w>-", { desc = "Resize window down" })

-- Go back/forward
vim.keymap.set("n", "gi", "<C-i>", { noremap = true, desc = "Jump forward" })
vim.keymap.set("n", "go", "<C-o>", { noremap = true, desc = "Jump backward" })

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "gj", function()
  vim.diagnostic.open_float()
end, opts)
