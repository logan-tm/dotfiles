" Enable mouse support
set mouse=a

" Enable syntax
syntax on

" Highlight current line
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

" Enable highlight search pattern
set hlsearch

" Enable smartcase search sensitivity
set ignorecase
set smartcase

" Indentation using spaces
" tabstop:      width of tab character
" softtabstop:  fine tunes the amount of whitespace added
" shiftwidth:   determines the amount of whitespace to add in normal mode
" expandtab:    when on use space instead of tab
" textwidth:    text wrap width
" autoindent:   autoindent in new line
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set textwidth   =79
set expandtab
set autoindent

" Show the matching part of pairs [] {} and ()
set showmatch

" Remove trailing whitespace from Python and Fortran files
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.f90 :%s/\s\+$//e
autocmd BufWritePre *.f95 :%s/\s\+$//e
autocmd BufWritePre *.for :%s/\s\+$//e

" Set compatibility to Vim only
set nocompatible

" Automatically wrap text the extends beyond the screen length
set wrap

" Encoding
set encoding=utf-8

" Show line numbers
set number

" Status bar
set laststatus=2

" Set gui colors by default
set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/space-vim-dark'
Plug 'preservim/nerdtree'

call plug#end()

" ===================================
" NOTE: May need to call :PlugInstall within vim to get the following options
" ===================================

" Set the default color scheme
colo space-vim-dark

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ===== Custom keymaps =====
nmap <F8> :NERDTreeToggle<CR>
