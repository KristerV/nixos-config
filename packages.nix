# User packages from your Arch setup

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development tools
    asdf-vm
    docker-compose
    go
    rustup
    nodejs
    nodePackages.npm
    python3
    python311Packages.pip
    elixir
    erlang
    git
    gnumake
    gcc

    # Browsers
    firefox
    chromium

    # Communication
    discord
    slack
    teams

    # Editors and IDEs
    vscode
    zed-editor
    vim

    # Media
    audacious
    audacity
    spotify
    vlc
    cheese

    # Office
    freeoffice  # If available, else libreoffice

    # Database tools
    dbeaver
    # beekeeper-studio # May need to build from source

    # System tools
    btop            # Better than bottom
    bind            # DNS tools
    arp-scan
    baobab          # Disk usage analyzer
    cups            # Printing
    powerstat

    # File managers
    nautilus  # Replacing caja

    # Cloud CLIs
    azure-cli
    flyctl
    stripe-cli

    # Utilities
    jq
    ripgrep
    fd
    fzf
    tree
    ncdu
    rsync
    rclone

    # Archive tools
    zip
    unzip
    p7zip

    # Networking
    caddy
    wireguard-tools
    openvpn

    # Fun
    neofetch
    cowsay
    lolcat
  ];

  # Programming language specific packages via nix-shell or direnv
  # Example: nix-shell -p nodejs python3 elixir

  # Some AUR packages alternatives:
  # - input-remapper -> Use `keyd` or `kmonad`
  # - swaylock-effects -> Already in sway.nix
  # - sway-audio-idle-inhibit -> May need manual build
  # - wdisplays -> Use `wlay` or `nwg-displays`
}