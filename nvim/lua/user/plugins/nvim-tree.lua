return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  sort = { sorter = "case_sensitive", },
  view = { width = 30, },
  filter = { dotfiles = true, },
  renderer = {
    highlight_git = true,
    highlight_opened_files = 'name',
    icons = {
      glyphs = {
        git = {
          unstaged = '!', renamed = '»', untracked = '?', deleted = '✘',
          staged = '✓', unmerged = '', ignored = '◌',
        },
      },
    },
  },

  config = function()
    require("nvim-tree").setup {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        -- custom keymap
        vim.keymap.set("n", '?', api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "<C-e>", vim.cmd.NvimTreeToggle, opts("ToggleTree"))
      end
    }
  end,
}
