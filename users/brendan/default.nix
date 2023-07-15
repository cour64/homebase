{ config, pkgs, ...  }:

{
  home.username = "brendan";
  home.homeDirectory = "/home/brendan";

  home.packages = with pkgs; [
    alacritty
    neovim
    gh

    # terminal tools
    ripgrep # replaces grep
    fd # replaces find
    fzf
    broot # replaces tree
    bat # replaces cat
    exa # replaces ls
    bottom # replace top/htop
    zoxide # replaces cd
  ];

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  programs = {
    alacritty = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Brendan de la Cour";
      userEmail = "brendan.dlc@gmail.com";
    };

    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };

    zsh = {
      enable = true;
      autocd = true;
      shellAliases = {
        ".." = "cd ..";
	"cat" = "bat";
	"tree" = "broot";
      };

      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting = {
        enable = true;
      };

      completionInit = ''
	autoload -Uz compinit
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)		# Include hidden files.
      '';

      initExtraFirst = ''
        autoload -Uz colors && colors
	setopt interactive_comments

	# PROMPT

	## Git
	autoload -Uz vcs_info
	precmd() { vcs_info }
        zstyle ':vcs_info:git:*' formats 'on %F{magenta} %b%f'

	## prompts
	setopt prompt_subst
	NEWLINE=$'\n' # New line shortcut
	PROMPT="''${NEWLINE}%B%F{cyan}%~%f%b %B''${vcs_info_msg_0_}%b''${NEWLINE}%B%(?.%F{green}.%F{red})➜ %f%b "
	RPROMPT="%n@%m [%*]"
      '';

      initExtra = ''
     	# VI MODE
	bindkey -v
	export KEYTIMEOUT=1

	## Use vim keys in tab complete menu:
	bindkey -M menuselect 'h' vi-backward-char
	bindkey -M menuselect 'k' vi-up-line-or-history
	bindkey -M menuselect 'l' vi-forward-char
	bindkey -M menuselect 'j' vi-down-line-or-history
	bindkey -v '^?' backward-delete-char

	## Change cursor shape for different vi modes.
	function zle-keymap-select () {
	    case $KEYMAP in
		vicmd) echo -ne '\e[1 q';;      # block
		viins|main) echo -ne '\e[5 q';; # beam
	    esac
	}
	zle -N zle-keymap-select
	zle-line-init() {
	    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	    echo -ne "\e[5 q"
	}
	zle -N zle-line-init
	echo -ne '\e[5 q' # Use beam shape cursor on startup.
	preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

	## Edit line in vim with ctrl-e:
	autoload edit-command-line; zle -N edit-command-line
	bindkey '^e' edit-command-line
	bindkey -M vicmd '^[[P' vi-delete-char
	bindkey -M vicmd '^e' edit-command-line
	bindkey -M visual '^[[P' vi-delete
      '';
    };

    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d";
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "TwoDark";
      };
      # extraPackages = with pkgs; [ batdiff batman batgrep batwatch ];
    };

    exa = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };

    bottom = {
      enable = true;
      settings = {
        flags = {
          avg_cpu = true;
	  temperature_type = "c";
	};

	colors = {
	  low_battery_color = "red";
	};
      };
    };

    ripgrep.enable = true;
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
