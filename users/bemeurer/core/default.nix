{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./btop.nix
    ./git.nix
    ./htop.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./xdg.nix
    ./zsh.nix
  ];

  home = {
    stateVersion = "21.11";
    packages = with pkgs; [ colorcheck exa fd kalker mosh neofetch ripgrep ];
  };

  programs = {
    bat.enable = true;
    fzf.enable = true;
    gpg.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";
}
