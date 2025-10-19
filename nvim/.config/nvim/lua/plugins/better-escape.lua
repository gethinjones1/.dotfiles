return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  opts = {
    mapping = { "jk", "kj" }, -- keys you want
    timeout = 200, -- how fast they must be typed
    keys = "<Esc>",
  },
}
