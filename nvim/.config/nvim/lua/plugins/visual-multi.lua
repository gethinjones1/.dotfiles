return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- optional: customize mappings
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>", -- select word under cursor
      ["Find Subword Under"] = "<C-n>",
      ["Select All"] = "<C-a>",
      ["Skip"] = "<C-x>",
      ["Remove Region"] = "<C-p>",
      ["Add Cursor Down"] = "<C-d>",
      ["Add Cursor Up"] = "<C-u>",
    }
  end,
}
