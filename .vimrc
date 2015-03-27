set nocompatible               " be iMproved
filetype off                   " required!

" Use Vim-plug
call plug#begin('~/.vim/plugged')

" colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'miyosui/solargrass256.vim'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree'

call plug#end()

"=====================
" Main configurations
"=====================
set title " show filename in titlebar of window
set t_Co=256 " set vim to work with 256 colors
colorscheme solargrass256 " Load Color Scheme
set number " show line numbers
set enc=utf-8 " set utf-8 encoding as default
set fileencoding=utf-8
set fileencodings=utf8,ucs-bom,prc

"============================
" FileTypes Configurations
"============================

au BufRead,BufNewFile *.md set filetype=markdown "use *.md as markdown files

"========================================================
" .vim_backup directory
"=========================================================
" Automatically create backup directories, writable by the group.
if filewritable($HOME) && ! filewritable($HOME . "/.vim_backup")
    silent execute "!umask 002; mkdir ${HOME}/.vim_backup"
endif
if filewritable($HOME) && ! filewritable($HOME . "/.vim_swap")
    silent execute "!umask 002; mkdir ${HOME}/.vim_swap"
endif
if filewritable($HOME) && ! filewritable($HOME . "/.vim_undo")
    silent execute "!umask 002; mkdir ${HOME}/.vim_undo"
endif
" use '/' to avoid collisions between files
set backupdir=$HOME/.vim_backup/ " backup files directory
set dir=$HOME/.vim_swap/ " swap files directory
set undofile " tell it to use an undo file
set undodir=$HOME/.vim_undo/ " set a directory to store the undo history

"==================================
" Global Behaviours
"==================================

" Paste code preserving format
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"For Emacs-style editing on the command-line: >
" start of line
:cnoremap <C-A>		<Home>
" back one character
:cnoremap <C-B>		<Left>
" delete character under cursor
:cnoremap <C-D>		<Del>
" end of line
:cnoremap <C-E>		<End>
" forward one character
:cnoremap <C-F>		<Right>
" recall newer command-line
:cnoremap <C-N>		<Down>
" recall previous (older) command-line
:cnoremap <C-P>		<Up>
" back one word
:cnoremap <Esc><C-B>	<S-Left>
" forward one word
:cnoremap <Esc><C-F>	<S-Right>


"==========================
" Settings for vim-latex
"==========================
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"=====================
" Mappings
"=====================
let mapleader=","
"Map key to ESC
imap jj <ESC>
cmap jj <ESC>
