{ pkgs, ... }:

{
  # Patch dwm
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.override {
	conf = ./dwm-config.h;
      };
    })
  ];

  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.dwm.enable = true;

  # Input
    
  ## Mouse accleration
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";
  services.xserver.libinput.touchpad.accelProfile = "flat";

  # Sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  ## Media keys
  sound.mediaKeys.enable = true;
  services.actkbd.enable = true;

  # Core packages
  environment.systemPackages = with pkgs; [
    dmenu
    firefox
    xdg-utils
    dunst
    gnome.gnome-keyring
    pavucontrol
  ];

  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
