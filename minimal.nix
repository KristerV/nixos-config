# Minimal NixOS Configuration - Just basics that work

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "nixos-vm";
    networkmanager.enable = true;
  };

  # Time and locale
  time.timeZone = "Europe/Tallinn";
  i18n.defaultLocale = "en_US.UTF-8";

  # Estonian keyboard
  services.xserver.xkb = {
    layout = "ee";
    variant = "us";
  };

  # User
  users.users.krister = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # SSH for remote access
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";  # For easy access
  };

  # Minimal packages that definitely work
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    htop
    openssh
  ];

  # Firewall - allow SSH
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  system.stateVersion = "24.11";
}