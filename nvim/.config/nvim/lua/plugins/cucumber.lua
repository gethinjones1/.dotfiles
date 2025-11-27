return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cucumber_language_server = {
          -- Make sure the server attaches to .feature buffers
          filetypes = { "cucumber", "gherkin", "feature" },
          settings = {
            cucumber = {
              -- Where your step definitions live (adjust to your layout)
              glue = {
                "**/step_definitions/*.rb",
              },
              -- Where your feature files live (optional; defaults are OK)
              features = {
                "**/*.feature",
              },
            },
          },
        },
      },
    },
  },
}
