return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        settings = {
          yaml = {
            customTags = {
              "!Ref scalar",
              "!Join sequence",
              "!Sub scalar",
              "!Sub sequence",
              "!GetAtt scalar",
              "!GetAtt sequence",
            },
          },
        },
      },
    },
  },
}
