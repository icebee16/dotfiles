return {
  -- mason: LSP/DAP/Linter/Formatter installer
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    config = true,
  },

  -- mason-lspconfig: bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig"
    },
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
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Python
      lspconfig.pyright.setup({})

      -- ruff
      lspconfig.ruff.setup({
        name = "ruff",
        cmd = { "ruff", "server", "--preview" }, -- Language Server モードで起動
        filetypes = { "python" },
        root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git"),
        init_options = {
          settings = {
            args = {}, -- 任意で追加引数を指定（例: {"--ignore", "E501"}）
          },
        },
      })

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
