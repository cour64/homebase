{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes"  ];
  
  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    zsh
    ripgrep # replaces grep
    fd # replaces find
    fzf
    jq
    tldr # replaces man
    lazygit 
    broot # replaces tree
    procs # replaces ps
    bat # replaces cat
    exa # replaces ls
    duf # replaces du
    bottom # replace top/htop
    zoxide # replaces cd
    gping # replace ping
    dig # replace nslookup
  ];

  environment.shells = with pkgs; [ zsh bash dash ]; 

  programs.zsh.enable = true;
}
