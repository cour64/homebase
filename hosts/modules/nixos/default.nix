{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  environment.binsh = "${pkgs.dash}/bin/dash";
}
