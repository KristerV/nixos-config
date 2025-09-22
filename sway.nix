# Sway Window Manager Configuration

{ config, pkgs, lib, ... }:

{
  # Enable Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock-effects   # Your fancy lock screen
      swayidle          # Idle management
      waybar            # Status bar
      wofi              # Alternative to albert (wayland native)
      albert            # Your launcher (might need XWayland)
      mako              # Notifications
      wl-clipboard      # Clipboard
      grim              # Screenshots
      slurp             # Region selection
      wf-recorder       # Screen recording
      light             # Backlight control
      pavucontrol       # Audio control GUI
      networkmanagerapplet # nm-applet
      blueman           # Bluetooth manager
      xwayland          # For X11 apps
      nautilus          # Alternative to caja (caja needs more setup)
      foot              # Terminal (wayland native alternative)
    ];
  };

  # XDG portal for screen sharing, file dialogs
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Sway config will be managed per-user
  # Copy your existing config to ~/.config/sway/config

  # Enable light for backlight control without sudo
  programs.light.enable = true;

  # Redshift for blue light filter (Tallinn coordinates from your sway config)
  services.redshift = {
    enable = true;
    temperature = {
      day = 5500;
      night = 3700;
    };
    location = {
      latitude = 59.328608;
      longitude = 24.564767;
    };
  };

  # PolicyKit for authentication dialogs
  security.polkit.enable = true;

  # For xfce-polkit equivalent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
  ];

  # Enable seat management
  services.seatd.enable = true;

  # Video drivers (for VM, will auto-detect)
  hardware.graphics = {
    enable = true;
  };
}