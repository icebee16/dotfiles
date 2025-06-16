-- ====================================
-- init.lua - Neovim Lua base entry point
-- ====================================

-- 基本オプションの読み込み
require("user.options")

-- keymapの設定
require("user.keymaps")

-- lazy.nvim の初期化（bootstrap込み）
require("user.lazy")
