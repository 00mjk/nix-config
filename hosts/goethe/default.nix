{ pkgs, ... }:
{
  imports = [
    ../../core
    ../../core/resolved.nix

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
      matchConfig.MACAddress = "dc:a6:32:a7:29:c3";
      networkConfig.IPv6PrivacyExtensions = "kernel";
    };
    wlan = {
      DHCP = "yes";
      matchConfig.MACAddress = "dc:a6:32:a7:29:c4";
      networkConfig.IPv6PrivacyExtensions = "kernel";
    };
  };

  time.timeZone = "America/Los_Angeles";

  # sops.secrets.root-password.sopsFile = ./root-password.yaml;
  # users.users.root.passwordFile = config.sops.secrets.root-password.path;
}
