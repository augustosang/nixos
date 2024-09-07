# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  users.users.augustosang = {
    isNormalUser = true;
    description = "Augusto Santana Guilherme";
    initialPassword = "gugugugu200505";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    packages = with pkgs; [];
  };

  console.keyMap = "br-abnt2";

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };

  security.rtkit.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # Tools
      git
      wget
      unzip
      p7zip
      htop
      obs-studio
      alacritty

      # Editors
      vim
      neovim
      emacs-unstable
      mg
      
      # Discord
      # Discord
      (vesktop.override {
        withSystemVencord = false;
      })
      (discord.override {
        withOpenASAR = true;
      })

      # Daily
      qbittorrent
      firefox

      # Utils
      feh
      libvterm-neovim
      emacs-lsp-booster
      asdf-vm

      # C/C++
      gcc
      ccls
      cmake

      # Office
      onlyoffice-bin
      hunspell
      hunspellDicts.pt_BR    
    ];
  };
  
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    feather-icon-font
  ];

  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";

      desktopManager = {
        wallpaper.mode = "fill";
      };

      displayManager = {
        session = [
	  {
	    manage = "desktop";
            name = "home-manager";
            start = ''
               ${pkgs.runtimeShell} $HOME/.hm-xsession &
               waitPID=$!

               ${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image
            '';
          }
        ];
      };
    };

    displayManager.ly.enable = true;
    displayManager.defaultSession = "home-manager";
    blueman.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    openssh = {
      enable = true;
    };

    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };


    printing.enable = true;
    libinput.enable = true;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
    mtr.enable = true;

    gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

