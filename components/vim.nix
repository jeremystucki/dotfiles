{
  home.file.".config/nvim/colors/theme.vim".source = ../resources/theme.vim;

  programs.neovim = {
    enable = true;

    viAlias = true;

    extraConfig = ''
      set nocompatible

      set clipboard=unnamedplus

      filetype plugin indent on

      syntax on
      set relativenumber
      set number

      set tabstop=4
      set shiftwidth=4
      set expandtab

      set hlsearch

      set scrolloff=4
      set sidescrolloff=5
      set incsearch

      set history=1000
      set undolevels=1000

      colorscheme theme

      set cursorline
      hi clear CursorLine

      nnoremap <CR> :noh<CR><CR>
    '';
  };
}