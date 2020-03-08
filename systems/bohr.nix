{ lib, ... }:
let
  secretPath = ../secrets/modules/ddclient-home-lovesegfault-com.nix;
  secretCondition = (builtins.pathExists secretPath);
  secret = lib.optionalAttrs secretCondition (import secretPath);
in
{
  imports = [
    ../core
    ../hardware/rpi3.nix
    ../modules/sshguard.nix
  ] ++ (import ../users).bemeurer;

  networking.hostName = "bohr";

  services.ddclient = (
    lib.recursiveUpdate {
      enable = true;
      ssl = true;
      protocol = "googledomains";
      domains = [ "home.lovesegfault.com" ];
    } secret
  );

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  time.timeZone = "America/Los_Angeles";
}
