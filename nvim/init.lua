-- ====================================
-- init.lua - Neovim Lua base entry point
-- ====================================

-- .envファイルから環境変数を読み込む処理
local openai_env = "~/.config/secrets/openai.env"
if vim.fn.filereadable(vim.fn.expand(openai_env)) == 1 then
  require("user.env").load(openai_env)
end

-- 基本オプションの読み込み
require("user.options")

-- keymapの設定
require("user.keymaps")

-- lazy.nvim の初期化（bootstrap込み）
require("user.lazy")
