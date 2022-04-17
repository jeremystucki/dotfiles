{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jeremy";
  home.homeDirectory = "/home/jeremy";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Jeremy Stucki";

    aliases = {
      co = "checkout";
      l  = "log --pretty=oneline-extra --date=human"; 
      lg = "l --graph";
    };

    extraConfig = {
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        file-style = "bold yellow ul";
      };
    };

    includes = [
      {
        condition = "gitdir:~/Documents/Code/Valora/";
        contents = {
          user = {
            email = "jeremy.stucki@valora.com";
            signingkey = "D91A765A08EB40E57C150BEC9E7DB73D85F91ED2";
          };
          commit.gpgSign = true;
        };
      }
    ];
  };
  
  programs.neovim = {
    enable = true;

    viAlias = true;

    # settings = {
    #   tabstop = 4;
    #   shiftwidth = 4;
    #   expandtab = true;

    #   number = true;
    #   relativenumber = true;

    #   history = 1000;
    # };

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

colorscheme oxeded

set cursorline
hi clear CursorLine

nnoremap <CR> :noh<CR><CR>
    '';
  };
  
  programs.zsh = {
    enable = true;

    enableSyntaxHighlighting = true;
    
    dirHashes = {
      valora = "$HOME/Documents/Code/Valora";
    };
    
    history = {
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
    };
    
    shellAliases = {
      ll = "ls -lah";
      cat = "bat";
    };

    initExtra = "
      setopt PROMPT_SUBST
      source ~/git-prompt.sh // TODO
      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWCOLORHINTS=true

      export PS1='
%1~$(__git_ps1)
$ '

      if [ \"$(hostname)\" = 'volt' ]; then
          bindkey '^[[3~' delete-char
      fi";
  };

  programs.bat.enable = true;
  
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 12.0;
        offset.y = 2;
      };

      colors = {
        primary = {
          background = "#2b2b2b";
          foreground = "#bbbbbb";
        };

        normal = {
          black   = "#ffffff";
          red     = "#ff6b68";
          green   = "#a8c023";
          yellow  = "#d6bf55";
          blue    = "#5394ec";
          magenta = "#ae8abe";
          cyan    = "#299999";
          white   = "#1f1f1f";
        };

        bright = {
          black   = "#575b70";
          red     = "#ff8785";
          green   = "#a8ca23";
          yellow  = "#ffff00";
          blue    = "#7eaef1";
          magenta = "#ff99ff";
          cyan    = "#6cdada";
          white   = "#e6e6e6";
        };
      };
    };
  };
}
