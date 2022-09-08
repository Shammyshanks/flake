{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "thor";
  home.homeDirectory = "/home/thor";

     

  nixpkgs.config.packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  programs.vim = {
    enable = true;
  };

  xdg = {
    enable = true;
    dataHome = "~/flake/locale/share";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtra = ''
      PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b '
'';
    autocd = true;
    dotDir = "~/.zshrc.save";
    defaultKeymap = "emacs";
    dirHashes = {
      docs = "$HOME/Documents";
      dl = "$HOME/Downloads";
      conf = "$HOME/.configs";
    };
    history = {
      path = "~/flake/zsh_history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo"];
      theme = "agnoster";
    };
    shellGlobalAliases = {
ls = "lsd -ah";
neofetch = "neofetch --ascii_distro nixos_old";
gitconfigs = "git clone https://github.com/shammyshanks/configs";
gitemacs = "git clone https://github.com/shammyshanks/emacs-current";
gitstump = "git clone https://github.com/shammyshanks/stumpwm";
githerb = "git clone https://github.com/shammyshanks/herbstluftwm";
gitpoly = "git clone https://github.com/shammyshanks/polybar";
gitgruv = "git clone https://github.com/shammyshanks/gruvbox";
gitkeys = "git clone https://github.com/shammyshanks/sxhkd";
gitfont = "git clone https://github.com/shammyshanks/font";
hc = "herbstclient";
nf = "clear && neofetch";
    };
  };

programs.qutebrowser = {
  enable = true;
  keyBindings = {
    normal = {
      "<CTRL-p>" = "scroll up";
    };
  };
};
  
  

programs.firefox = {
  enable = true;
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    darkreader
    bypass-paywalls-clean
    vim-vixen
    vimium
    stylus
    bitwarden
    decentraleyes
    i-dont-care-about-cookies
    https-everywhere
    netflix-1080p
    tree-style-tab
    violentmonkey
  ];
  profiles.default = {
    id = 0;
    name = "Default";
    isDefault = true;
    settings = {
  "browser.startup.homepage" = "https://nixos.org";

    };
  };
};


# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}


