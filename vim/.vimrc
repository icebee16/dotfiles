""===================""
""   autocmd setup   ""
""===================""
if !&compatible
	set nocompatible
endif
"" reset augroup
augroup MyAutoCmd
	autocmd!
augroup END

""=====================""
""   python3 setting   ""
""=====================""
""let g:deoplete#sources#jedi#python_path = $XDG_CONFIG_HOME . "/.pyenv/shims/python"

""==============""
""   dein.vim   ""
""==============""
"" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
"" プラグイン読み込み＆キャッシュ作成
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	let g:rc_dir		= expand('~/dotfiles/vim/rc')
	let s:toml			= g:rc_dir . '/dein.toml'
	let s:lazy_toml	= g:rc_dir . '/dein_lazy.toml'
	call dein#load_toml(s:toml,				{'lazy': 0})
	call dein#load_toml(s:lazy_toml,	{'lazy': 1})
	call dein#end()
	call dein#save_state()
endif
"" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
	call dein#install()
endif
"" 
call map(dein#check_clean(), "delete(v:val, 'rf')")

""===================""
""   set statement   ""
""===================""
set noswapfile
set nobackup
set nowritebackup
set number
set ambiwidth=double
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set nrformats-=octal
set hidden
set virtualedit=onemore
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set laststatus=2
set mouse=a
set hlsearch
set viminfo+=n~/dotfiles/vim/.viminfo

""=============""
""   keybind   ""
""=============""
"" cursor move
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <C-p>
nnoremap <C-p> 20k
nnoremap <C-n> 20j
vnoremap <C-p> 20k
vnoremap <C-n> 20j
"" tab move
nnoremap <C-u> u
nnoremap sh :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sf gt
nnoremap sb gT
nnoremap sT :<C-u>Unite tab<CR>
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
"" mode change
inoremap <silent> jj <ESC>:<C-u>w<CR>
