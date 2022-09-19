# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



{
imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix

  ];

nix = {
  package = pkgs.nixFlakes;
  extraOptions = " experimental-features = nix-command flakes";
};

# Bootloader.
boot.loader.grub = {
enable = true;
device = "/dev/sda";
useOSProber = true;
theme = pkgs.fetchFromGitHub {
  owner = "shvchk";
  repo = "fallout-grub-theme";
  rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
 sha256 = "1mbajhff2wjyclakk2dabjlz5sg1mbf070mr6828gkwd7rycnjzf";
};
 };
# Bluetooth
hardware.bluetooth.enable = true;
services.blueman.enable = true;
networking = {
  hostName = "nixos"; # Define your hostname.
  wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    networks = {
  briggsx1 = { psk = "Jr343434" ;

             };
    };
  };
};

# Set your time zone.
time.timeZone = "America/Los_Angeles";
i18n.defaultLocale = "en_US.utf8";

# Services
services = {
  pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};
  printing.enable = true;
  xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
    layout = "us"; #keyboard layout
    xkbVariant = "";
    windowManager = { 
      herbstluftwm.enable = true;
      stumpwm.enable = true;
      awesome.enable = true;
};
  };
};

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;

users = {
 defaultUserShell = pkgs.zsh; 
  users.thor = {
  isNormalUser = true;
  description = "thor";
  extraGroups = [ "networkmanager" "wheel" ];
  };
};

# Allow unfree and broken packages
nixpkgs.config = {
allowUnfree = true;
allowBroken = true;
packageOverrides = pkgs: {
nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
  inherit pkgs;
  };
};
};

fonts.fonts = with pkgs; [
  emacs-all-the-icons-fonts
  font-awesome
  hack-font
  nerdfonts
];

environment.systemPackages = with pkgs; [
papirus-folders
bat
fzf
btop
nix-prefetch-git
dunst
rofi
plank
catppuccin-gtk
ytfzf
mpv  
banner
pipes
boxes
cbonsai
catimg
cmatrix
cava
tty-clock
python
lsd  
pywal
wget
xorg.xinit
xorg.xorgserver
xorg.xrdb
xorg.xmodmap
git
obsidian
brave
blueman
firefox
emacs
gotop
gtop
gcc
yafetch
bunnyfetch
screenfetch  
neofetch
pfetch
cowsay
feh
syncthing
polybar
sxhkd
dmenu
picom
ranger
screenkey
youtube-dl
  (st.overrideAttrs (oldAttrs: rec {
    src = fetchFromGitHub {
      owner = "LukeSmithxyz";
      repo = "st";
      rev = "8ab3d03681479263a11b05f7f1b53157f61e8c3b";
      sha256 = "1brwnyi1hr56840cdx0qw2y19hpr0haw4la9n0rqdn0r2chl8vag";
    };
    buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
    }))
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
