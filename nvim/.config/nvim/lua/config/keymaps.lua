-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ~/.config/nvim/lua/config/keymaps.lua
vim.schedule(function()
  pcall(vim.keymap.del, "i", "<Up>")
  pcall(vim.keymap.del, "i", "<Down>")
end)
local map = vim.keymap.set
local silent = { silent = true, noremap = true }
-- Explorer (netrw)
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw (project view)" })
-- Select all
map("n", "<leader>a", "ggVG", silent)

-- Splits
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split", silent = true })
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split", silent = true })

-- Navigate splits quickly (these match LazyVim defaults; defining again is fine)
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-l>", "<C-w>l", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)

map({ "n", "v" }, "<Left>", "", { noremap = true, silent = true })
map({ "n", "v" }, "<Right>", "", { noremap = true, silent = true })
map({ "n", "v" }, "<Up>", "", { noremap = true, silent = true })
map({ "n", "v" }, "<Down>", "", { noremap = true, silent = true })

map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", { silent = true })

local dap = require("dap")

-- =====================
-- Core execution
-- =====================

map("n", "<leader>dc", dap.continue, { desc = "DAP: Start / Continue" })
map("n", "<leader>dx", dap.terminate, { desc = "DAP: Terminate" })
map("n", "<leader>dr", dap.restart, { desc = "DAP: Restart" })

-- =====================
-- Stepping
-- =====================

map("n", "<leader>dn", dap.step_over, { desc = "DAP: Step over" })
map("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
map("n", "<leader>do", dap.step_out, { desc = "DAP: Step out" })

-- =====================
-- Breakpoints
-- =====================

map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })

map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Conditional breakpoint" })

map("n", "<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP: Logpoint" })

-- =====================
-- Inspection / Debug views
-- =====================

map("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "DAP: Hover variable" })

map("n", "<leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "DAP: Scopes" })

map("n", "<leader>dR", dap.repl.open, { desc = "DAP: Open REPL" })

-- =====================
-- Go-specific helpers (AoC TDD essentials)
-- =====================

pcall(function()
  local dapgo = require("dap-go")
  map("n", "<leader>dt", dapgo.debug_test, { desc = "Go: Debug nearest test" })
end)

-- =====================
-- Optional: DAP UI toggle
-- =====================

pcall(function()
  local dapui = require("dapui")
  map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
end)
