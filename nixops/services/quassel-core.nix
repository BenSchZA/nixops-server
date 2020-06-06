{ ... }: {
  services.quassel.enable = true;
  services.quassel.interfaces = [ "0.0.0.0" ];
  networking.firewall.allowedTCPPorts = [ 4242 ];
}
