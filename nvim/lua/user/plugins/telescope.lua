return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope: Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope: Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope: Help Tags" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = {
          horizontal = { width = 0.9 },
          vertical = { width = 0.9 },
        },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    })
  end,
}
