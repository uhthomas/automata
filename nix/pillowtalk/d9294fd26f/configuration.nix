{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    bonds.bond0 = {
      interfaces = [ "enp6s0f0" "enp6s0f1" ];
      driverOptions = {
        lacp_rate = "fast";
        miimon = "100";
        mode = "802.3ad";
        xmit_hash_policy = "layer3+4";
      };
    };
    interfaces = {
      eno1.useDHCP = true;
      eno2.useDHCP = true;
      eno3.useDHCP = true;
      eno4.useDHCP = true;
      bond0.useDHCP = true;
    };
  };

  system.stateVersion = "20.09";
}
