return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    -- Use Mason's clangd path if available
    local mason_clangd = nil
    pcall(function()
      local mr = require("mason-registry")
      if mr.has_package("clangd") then
        mason_clangd = mr.get_package("clangd"):get_install_path() .. "/bin/clangd"
      end
    end)
    local clangd_bin = mason_clangd or "clangd"

    -- Build a --query-driver list for any installed ESP32 toolchains
    local function glob(p)
      local out = vim.fn.glob(p, 0, 1)
      return out
    end
    local drivers = {}
    for _, g in ipairs({
      "~/.platformio/packages/toolchain-xtensa-esp32*/bin/xtensa-esp32-elf*",
      "~/.platformio/packages/toolchain-xtensa-esp32s2*/bin/xtensa-esp32s2-elf*",
      "~/.platformio/packages/toolchain-xtensa-esp32s3*/bin/xtensa-esp32s3-elf*",
      "~/.platformio/packages/toolchain-riscv32-esp*/bin/riscv32-esp-elf*",
    }) do
      for _, p in ipairs(glob(g)) do
        table.insert(drivers, vim.fn.expand(p))
      end
    end

    opts.servers = opts.servers or {}
    opts.servers.clangd = {
      cmd = {
        clangd_bin,
        "--background-index",
        "--clang-tidy=false",
        "--header-insertion=never",
        "--query-driver=" .. table.concat(drivers, ","),
      },
      root_dir = function(fname)
        return util.root_pattern("compile_commands.json", "platformio.ini", ".git")(fname)
      end,
    }

    -- Optional: auto-link compile_commands.json if it exists only under .pio
    opts.setup = opts.setup or {}
    opts.setup.clangd = function()
      local cc = vim.fn.getcwd() .. "/compile_commands.json"
      if vim.fn.filereadable(cc) == 0 then
        local p = ".pio/build/esp32dev/compile_commands.json"
        if vim.fn.filereadable(p) == 1 then
          vim.fn.system({ "ln", "-sf", p, "compile_commands.json" })
        end
      end
      return false
    end

    return opts
  end,
}
