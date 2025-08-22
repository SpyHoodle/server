{ lib, hostname, ... }:

{
  # Disable DHCP
  networking.useDHCP = lib.mkDefault false;

  # Hostname
  networking.hostName = "${hostname}";

  # Disable wireless support & configuration
  networking.wireless.enable = false;

  # Configure a static ip address
  networking.interfaces.end0.ipv4.addresses = [
    {
      address = "192.168.1.170";
      prefixLength = 25;
    }
  ];
  networking.defaultGateway = "192.168.1.254";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
}
