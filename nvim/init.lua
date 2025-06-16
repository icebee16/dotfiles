-- ====================================
-- init.lua - Neovim Lua base entry point
-- ====================================

-- 基本オプションの読み込み
require("user.options")

-- lazy.nvim の初期化（bootstrap込み）
require("user.lazy")
