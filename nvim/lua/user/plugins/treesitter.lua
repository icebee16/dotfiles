return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "html",
        "python",
        "sql",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,

      highlight = {
        enable = true,
        disable = {
          "markdown",
          "markdown_inline",
        },
      },

      indent = {
        enable = true,
        disable = {
          "markdown",
        },
      },
    })
  end,
}
