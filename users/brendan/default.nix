{ config, pkgs, ...  }:

{
  home.username = "brendan";
  home.homeDirectory = "/home/brendan";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
    
    alacritty
    neovim
    gh

    # terminal tools
    ripgrep # replaces grep
    fd # replaces find
    fzf
    broot # replaces tree
    bat # replaces cat
    eza # replaces ls
    bottom # replace top/htop
    zoxide # replaces cd
  ];

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  # Dotfiles
  xdg = {
    enable = true;
    configFile = {
      alacritty = {
        enable = true;
        source = ./alacritty.yaml;
	target = "alacritty/alacritty.yml";
      };
    };
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
      gitCredentialHelper.enable = true;
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autocd = true;
      shellAliases = {
        ".." = "cd ..";
	"cat" = "bat";
	"tree" = "broot";
      };
      history = {
        ignoreSpace = true;
        ignoreDups = true;
	extended = true;
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

      initExtra = builtins.readFile ./zshrc;
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

    eza = {
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

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
