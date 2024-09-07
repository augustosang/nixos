{ config, pkgs, ... }:

{
  imports = [
    ./programs/i3.nix
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/polybar.nix
    ./programs/dunst.nix
  ];

  home.username = "augustosang";
  home.homeDirectory = "/home/augustosang";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    # i3
    pkgs.i3status
    pkgs.i3lock
    pkgs.i3blocks
    pkgs.dmenu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  services.flameshot = {
    enable = true;
    
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartuoLaunchMessage = false;
      };
    };
  };

  
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash.enable = true;
}
