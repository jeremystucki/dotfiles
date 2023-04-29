{ pkgs, ... }:

{
  home.file.".config/nvim/colors/theme.vim".source = ../resources/theme.vim;

  programs.neovim = {
    enable = true;

    viAlias = true;

    plugins = with pkgs.vimPlugins; [
        fzf-vim
        kotlin-vim
        vim-commentary
        vim-fugitive
        vim-nix
        vim-obsession
        vim-repeat
        vim-tmux-navigator
        vim-unimpaired
    ];

    extraConfig = ''
      set clipboard+=unnamedplus

      filetype plugin indent on

      syntax on
      set relativenumber
      set number

      set tabstop=4
      set shiftwidth=4
      set expandtab

      set ic

      set scrolloff=4
      set sidescrolloff=5

      set history=1000
      set undolevels=1000

      colorscheme theme

      set cursorline
      hi clear CursorLine

      nnoremap <CR> :noh<CR><CR>
    '';
  };
}
