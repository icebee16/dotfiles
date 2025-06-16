-- " ================= "
-- "   set statement   "
-- " ================= "
local set = vim.opt

-- ファイル管理
set.swapfile = false
set.backup = false
set.writebackup = false
set.viminfo:append("n~/dotfiles/nvim/.viminfo")

-- 表示
set.number = true
set.list = true
set.listchars = {
  tab = "»-",
  trail = "-",
  eol = "↲",
  extends = "»",
  precedes = "«",
  nbsp = "%"
}
set.laststatus = 2
set.hlsearch = true
set.winblend = 20
set.pumblend = 20
set.termguicolors = true

-- インデント
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0

-- 検索
set.nrformats:remove('octal')

-- クリップボード
set.clipboard:append('unnamedplus')

-- その他
set.ambiwidth = 'double'
set.hidden = true
set.virtualedit = 'onemore'
set.whichwrap = 'b,s,[,],<,>'
set.backspace = 'indent,eol,start'
set.mouse = 'a'
