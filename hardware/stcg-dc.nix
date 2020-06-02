{ lib, pkgs, ... }: {

  imports = [ ./efi.nix ./no-mitigations.nix ./nvidia.nix ];

  boot = rec {
    initrd.availableKernelModules =
      [ "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment.noXlibs = true;

  hardware.enableRedistributableFirmware = true;

  networking = {
    interfaces.enp1s0f0.useDHCP = true;
    interfaces.enp24s0f0.useDHCP = true;
    useDHCP = false;
  };

  nix = {
    maxJobs = 64;
    systemFeatures = [ "benchmark" "nixos-test" "big-parallel" "kvm" "gccarch-skylake" ];
  };

  nixpkgs.localSystem.system = "x86_64-linux";

  services.fstrim.enable = true;
  services.sshguard.enable = lib.mkForce false;
}
