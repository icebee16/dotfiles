-- エイリアス
local keymap = vim.keymap.set

-- カーソル移動
keymap('n', 'j', 'gj', { noremap = true })
keymap('n', 'k', 'gk', { noremap = true })
keymap('n', 'gj', 'j', { noremap = true })
keymap('n', 'gk', 'k', { noremap = true })
keymap('n', '<S-h>', '^', { noremap = true })
keymap('n', '<S-j>', '}', { noremap = true })
keymap('n', '<S-k>', '{', { noremap = true })
keymap('n', '<S-l>', '$', { noremap = true })
keymap('i', '<C-p>', '<Up>', { noremap = true })
keymap('i', '<C-n>', '<Down>', { noremap = true })
keymap('i', '<C-f>', '<Right>', { noremap = true })
keymap('i', '<C-b>', '<Left>', { noremap = true })
keymap('i', '<C-a>', '<C-p>', { noremap = true })
keymap('n', '<C-p>', '20kzz', { noremap = true })
keymap('n', '<C-n>', '20jzz', { noremap = true })
keymap('v', '<C-p>', '20kzz', { noremap = true })
keymap('v', '<C-n>', '20jzz', { noremap = true })

-- タブ移動
keymap('n', '<C-u>', 'u', { noremap = true })
keymap('n', 'sh', ':<C-u>sp<CR>', { noremap = true })
keymap('n', 'sv', ':<C-u>vs<CR>', { noremap = true })
keymap('n', 'st', ':<C-u>tabnew<CR>', { noremap = true })
keymap('n', 'sf', 'gt', { noremap = true })
keymap('n', 'sb', 'gT', { noremap = true })
keymap('n', '<Esc><Esc>', ':<C-u>set nohlsearch<CR>', { noremap = true, silent = true })
keymap('n', '<S-Left>', '<C-w><<CR>', { noremap = true })
keymap('n', '<S-Right>', '<C-w>><CR>', { noremap = true })
keymap('n', '<S-Up>', '<C-w>-<CR>', { noremap = true })
keymap('n', '<S-Down>', '<C-w>+<CR>', { noremap = true })

-- モード変更
keymap('i', 'jj', '<Esc>:<C-u>w<CR>', { noremap = true, silent = true })
keymap('n', '<C-e>', vim.cmd.NvimTreeToggle)

-- コマンドライン補完
keymap("c", "<C-n>", "<Down>", { silent = true })
keymap("c", "<C-p>", "<Up>", { silent = true })
