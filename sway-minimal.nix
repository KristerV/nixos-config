# Minimal Sway Setup - Just Core Components

{ config, pkgs, lib, ... }:

{
  # Enable Sway with minimal packages
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      # Only essential packages that definitely exist
      waybar            # Status bar
      foot              # Terminal
      wofi              # Launcher (wayland native)
      swaylock          # Basic lock (not swaylock-effects yet)
      swayidle          # Idle management
      mako              # Notifications
      wl-clipboard      # Clipboard
      firefox           # Browser
    ];
  };

  # XDG portal for screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable seat management
  services.seatd.enable = true;

  # Video drivers
  hardware.graphics = {
    enable = true;
  };

  # Basic fonts
  fonts.packages = with pkgs; [
    liberation_ttf
    font-awesome
  ];
}