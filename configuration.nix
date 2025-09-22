# NixOS Configuration - Sway Desktop
# Based on your Arch setup

{ config, pkgs, ... }:

{
  imports = [
    # Hardware config will be generated during install
    ./hardware-configuration.nix
    # Separate configs for organization
    ./sway.nix
    ./packages.nix
  ];

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Networking
  networking = {
    hostName = "nixos-vm"; # Change this
    networkmanager.enable = true;
  };

  # Time zone and locale
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  # Estonian keyboard layout
  services.xserver.xkb = {
    layout = "ee";
    variant = "us";
  };

  # Console keymap
  console.keyMap = "us";

  # User account
  users.users.krister = {
    isNormalUser = true;
    description = "Krister";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages (needed for Discord, Slack, etc)
  nixpkgs.config.allowUnfree = true;

  # Enable sound (pipewire handles this now)
  services.pulseaudio.enable = false; # Using pipewire instead
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # PostgreSQL (matching your Arch setup)
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  # System packages (minimal base)
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    htop
    unzip
    gnome.gnome-terminal
  ];

  # ZSH configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Open firewall for development
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000 4000 # Common dev ports
      5432      # PostgreSQL
      8080 8000 # Web servers
    ];
  };

  # System version
  system.stateVersion = "24.11";
}