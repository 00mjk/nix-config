{ pkgs, ... }:
{
  imports = [
    ../../core

    ../../hardware/rpi4.nix

    ../../users/bemeurer

    ./dhcpd4.nix
  ];

  console = {
    font = "ter-v28n";
    packages = with pkgs; [ terminus_font ];
  };

  networking = {
    wireless.iwd.enable = true;
    hostName = "goethe";
  };

  nix.gc = {
    automatic = true;
    options = "-d";
  };

  systemd.network.networks = {
    lan = {
      DHCP = "no";
      address = [ "192.168.2.1/24" ];
      linkConfig.RequiredForOnline = "no";
      matchConfig.Name = "eth0";
      networkConfig.IPv6PrivacyExtensions = "kernel";
    };
    wlan = {
      DHCP = "yes";
      matchConfig.Name = "wlan0";
      networkConfig.IPv6PrivacyExtensions = "kernel";
    };
  };

  time.timeZone = "America/Los_Angeles";

  # sops.secrets.root-password.sopsFile = ./root-password.yaml;
  # users.users.root.passwordFile = config.sops.secrets.root-password.path;
}
