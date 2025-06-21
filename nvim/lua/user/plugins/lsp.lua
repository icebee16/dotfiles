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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Python
      lspconfig.pyright.setup({})

      -- Lua (Neovim用設定)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Markdown
      lspconfig.marksman.setup({})

      -- Shell
      lspconfig.bashls.setup({
        filetypes = { "sh", "bash", "zsh" },
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command|.zshrc|.zsh)"
          },
        },
      })

      -- SQL
      lspconfig.sqlls.setup({})
    end,
  },
}
