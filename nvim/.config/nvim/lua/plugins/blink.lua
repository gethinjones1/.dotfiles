return {
  { "hrsh7th/nvim-cmp", enabled = false },

  {
    "saghen/blink.cmp",
    lazy = false, -- ← critical: loads before LazyVim's VeryLazy stuff
    version = "v1.*", -- Use stable release with prebuilt binaries
    build = "cargo build --release",
    implementation = "prefer_rust_with_warning",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      keymap_priority = 1000, -- ← also critical
    },
  },
}
