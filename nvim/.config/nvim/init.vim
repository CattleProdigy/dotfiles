" All of your Plugins must be added before the following line
filetype plugin indent on    " required

" Trim trailing whitespace on save
autocmd BufWritePre *.{java,cpp,c,h,hpp,cu,md,toml} :%s/\s\+$//e

" Enter/Exit insert mode automatically when switching to a terminal buffer
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

call plug#begin('~/.config/nvim/plugged')

  Plug 'vim-airline/vim-airline'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'rust-lang/rust.vim'
  Plug 'https://github.com/ctrlpvim/ctrlp.vim'
  Plug 'Valloric/YouCompleteMe'
  Plug 'https://github.com/rhysd/vim-clang-format'

  "Plug 'https://github.com/tpope/vim-commentary'
call plug#end()

" Fmt on save
let g:rustfmt_autosave = 1

"Don't ask about YCM Conf
let g:ycm_confirm_extra_conf = 0

" let g:ycm_enable_diagnostic_highlighting = 0
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_enable_diagnostic_signs = 0

" " Hide the scratch buffer
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"
" let g:ycm_use_clangd = 0
"
" YCM Jump
 nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Tabline
let g:airline#extensions#tabline#enabled = 1

" Tab through open buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

set nocompatible

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
"set spell

set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set smartindent
"set autoindent
set cindent
set backspace=indent,eol,start
set laststatus=2
set undofile
set ignorecase
set smartcase
set cc=100

set path+=$PWD/**

" Enable mouse scrolling
set mouse=a

set t_Co=256
colors zenburn
syntax on

" I always hold shift on accident
command W w
command Wq wq

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_custom_ignore = 'target\|proptest_regressions'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Save your swap files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.config/nvim/swap') == 0
  :silent !mkdir -p ~/.config/nvim/swap >/dev/null 2>&1
endif
set directory=~/.config/nvim/swap
set directory+=.

" viminfo stores the the state of your previous editing session
"set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/config/nvim/undo') == 0
    :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
  set undodir=~/.config/nvim/undo
  set undofile
endif

" Clang Format
let g:clang_format#command = 'clang-format'
autocmd FileType c,cpp,objc,cu nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc,cu vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Skip quick fix when moving through buffers
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
