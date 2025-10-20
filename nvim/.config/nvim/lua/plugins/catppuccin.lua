return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- options: latte, frappe, macchiato, mocha
      -- other config options here if you want
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
