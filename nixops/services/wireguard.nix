{ ... }:
let env = import ../env.nix;
in {
  networking.nat.enable = true;
  networking.nat.externalInterface = "bond0";
  networking.nat.internalInterfaces = [ "wg0" ];
  # services.dnscrypt-proxy = {
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that Wireguard listens to. Must be accessible by the client.
      listenPort = 51820;

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "${env.WIREGUARD_PRIVATE_KEY_FILE}";

      peers = [
        # List of allowed peers.
        { # Feel free to give a meaning full name
          # Public key of the peer (not a file path).
          publicKey = "${env.WIREGUARD_PUBLIC_KEY}";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
