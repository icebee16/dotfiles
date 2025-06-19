return {
  -- mason: LSP/DAP/Linter/Formatter installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- mason-lspconfig: bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",      -- Python
          "lua_ls",       -- Lua (Neovim config)
          "marksman",     -- Markdown
          "bashls",       -- Shell (sh, bash)
          "sqlls",        -- SQL
        },
        automatic_installation = true,
      })
    end,
  },

  -- lspconfig: Neovim LSP client configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Python
      lspconfig.pyright.setup({})

      -- Lua (Neovim用設定)
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- Markdown
      lspconfig.marksman.setup({})

      -- Shell
      lspconfig.bashls.setup({
        filetypes = { "sh", "bash", "zsh" },
      })

      -- SQL
      lspconfig.sqlls.setup({})
    end,
  },
}
