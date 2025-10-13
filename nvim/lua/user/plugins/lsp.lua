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
          "pyright",      -- pyright
          "ruff",         -- ruff
          "lua_ls",       -- Lua (Neovim config)
          "marksman",     -- Markdown
          "bashls",       -- Shell (sh, bash)
          "sqlls",        -- SQL
          "html",         -- HTML
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- capabilities settings
      capabilities.general = capabilities.general or {}
      capabilities.general.positionEncodings = { "utf-16" }
      capabilities.offsetEncoding = { "utf-16" }

      -- Pyright：型チェック寄せ ＋ “Ruffと被る系”を抑制
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              -- 型チェックの強さ： "off" | "basic" | "standard" | "strict"
              typeCheckingMode = "basic",
              -- 開いているファイルだけ解析（必要なら "workspace" に上げる）
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              -- Ruff と重複しがちな診断を抑制
              diagnosticSeverityOverrides = {
                reportUnusedImport   = "none",
                reportUnusedVariable = "none",
                reportUnusedFunction = "none",
                -- 必要に応じて：
                -- reportWildcardImportFromLibrary = "none",
                -- reportMissingTypeStubs = "information",
              },
            },
          },
        },
      })

      -- Ruff：Lint & Fix を担当（E/F/I を軸に）
      vim.lsp.config("ruff", {
        capabilities = capabilities,
        cmd = { "ruff", "server", "--preview" },
        filetypes = { "python" },
        -- root_dir = vim.fs.dirname(vim.fs.find({
        --   "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git"
        -- }, { upward = true })[1]),
        init_options = {
          settings = {
            args = {},
          },
        },
      })

      -- Lua (Neovim)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Markdown
      vim.lsp.config("marksman", {capabilities = capabilities})

      -- Shell
      vim.lsp.config("bashls", {
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh" },
        settings = {
          bashIde = { globPattern = "*@(.sh|.inc|.bash|.command|.zshrc|.zsh)" },
        },
      })

      -- SQL
      vim.lsp.config("sqlls", {capabilities = capabilities})

      -- HTML
      vim.lsp.config("html", {
        capabilities = capabilities,
        -- htmldjango 等も拾いたい場合は明示
        filetypes = { "html", "templ", "htmldjango", "ejs" },
        init_options = {
          provideFormatter = true,  -- 任意（内蔵フォーマッタ使用）
        },
      })

      -- 有効化（手動 attach）
      for _, server in ipairs({ "pyright", "ruff", "lua_ls", "marksman", "bashls", "sqlls", "html" }) do
        vim.lsp.enable(server)
      end
    end,
  },
}
