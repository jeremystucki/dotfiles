set nocompatible
filetype off

filetype plugin indent on

syntax on
set relativenumber
set number

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

colorscheme oxeded

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

set cursorline

set clipboard=unnamed
set backspace=2

