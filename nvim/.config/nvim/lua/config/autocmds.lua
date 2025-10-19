-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "natural" },
  callback = function()
    vim.opt_local.colorcolumn = "73"
    vim.o.guifont = "3270 Nerd Font:h16"
    -- "s1:/*,mb:*,ex:*/,    -- start, middle, end - C style block with a 1-offset middle
    -- ://   -- double slash stylee
    -- b:#   -- hash with a blank after it
    -- :%    --
    -- :XCOMM
    -- n:>
    -- fb:-
    -- fb:•
    --
    -- Natural supports as comment starts on first column
    -- "* "
    -- "**"
    -- "/*"
    vim.o.comments = "b:/*,b:**,b:*"
    vim.o.commentstring = "/* %s"
  end,
})
