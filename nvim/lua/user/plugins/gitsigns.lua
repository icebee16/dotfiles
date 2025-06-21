return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    signcolumn = true,  -- Git変更を signcolumn に表示
    numhl = false,      -- 行番号ハイライトは無効
    linehl = false,     -- 行全体ハイライトは無効
    current_line_blame = false, -- blame表示は初期状態では無効
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true })
      end

      -- hunk間移動
      map('n', ']c', function() gs.nav_hunk('next') end, 'Next Git hunk')
      map('n', '[c', function() gs.nav_hunk('prev') end, 'Prev Git hunk')
    end
  },
  -- gitsigns.lua に以下を追加（lazy.nvim使用時）
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
