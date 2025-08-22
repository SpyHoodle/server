{ pkgs, ... }:

{
  # System-wide packages
  # I want these available for all users at all times
  environment.systemPackages = with pkgs; [
    # Processes
    appimage-run
    killall
    htop

    # Filesystems
    dosfstools
    btrfs-progs
    ntfs3g
    exfatprogs

    # Archives
    zip
    unrar
    unzip
    p7zip

    # Cli tools
    yt-dlp
    ripgrep
    wget
    bat

    # Editors
    kakoune
    neovim

    # XDG
    xdg-utils
    xdg-user-dirs

    # Git
    git
  ];
}
