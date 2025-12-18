return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap_go = require("dap-go")
      dap_go.setup()

      -- OPTIONAL: keymaps specifically for Go test debugging
      vim.keymap.set("n", "<leader>dt", function()
        dap_go.debug_test()
      end, { desc = "Debug nearest Go test" })

      vim.keymap.set("n", "<leader>df", function()
        dap_go.debug_file()
      end, { desc = "Debug current Go file (main)" })
    end,
  },
}
