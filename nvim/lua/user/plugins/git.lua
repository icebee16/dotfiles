return {
  -- 1) gitsigns: 行単位のhunk表示/操作
  {
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
      signcolumn = true,
      numhl = false,
      linehl = false,
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true })
        end
        -- hunk移動
        map('n', ']c', function() gs.nav_hunk('next') end, 'Next Git hunk')
        map('n', '[c', function() gs.nav_hunk('prev') end, 'Prev Git hunk')

        -- 代表操作（必要なら追記）
        -- map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        -- map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        -- map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  -- 2) diffview: PR風の変更一覧/左右diff UI
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles", "DiffviewFileHistory",
    },
    opts = {
      -- 既定でOK。必要に応じてhooksやiconsを後で詰める
    },
    keys = {
      -- 全変更をPR風に確認（例: mainと比較）
      { "<leader>gd", function() vim.cmd("DiffviewOpen") end, desc = "Diffview: Open" },
      { "<leader>gD", function() vim.cmd("DiffviewClose") end, desc = "Diffview: Close" },
      -- ファイル履歴（%でカレントファイル）
      { "<leader>gh", function() vim.cmd("DiffviewFileHistory %") end, desc = "Diffview: File history (%)" },
      { "<leader>gH", function() vim.cmd("DiffviewFileHistory") end, desc = "Diffview: Repo history" },
    },
  },

  -- 3) neogit: Magit風UI。diffviewと連携可能
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",   -- 必須
      "sindrets/diffview.nvim",  -- 任意: Diff統合
    },
    opts = {
      integrations = { diffview = true }, -- diffview連携を有効化
      -- あとはデフォルトでOK。commit_popup等は後で調整
    },
    keys = {
      { "<leader>gg", function() require("neogit").open({ kind = "tab" }) end, desc = "Neogit (tab)" },
      { "<leader>gc", function() require("neogit").open({ "commit" }) end, desc = "Neogit: Commit popup" },
      { "<leader>gp", function() require("neogit").open({ "pull" }) end, desc = "Neogit: Pull" },
      { "<leader>gP", function() require("neogit").open({ "push" }) end, desc = "Neogit: Push" },
    },
  },
}
