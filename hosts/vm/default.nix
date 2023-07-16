# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ../modules/core.nix
      ../modules/nixos
      ../modules/nixos/dwm-de
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "us";
  };

  users.users.brendan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "23.05";
}
