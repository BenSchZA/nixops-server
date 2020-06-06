{ config, pkgs, ... }:
let env = import ./env.nix;
in {
  environment.systemPackages = with pkgs; [
    git
    gotop
    gotty
    docker-compose
    neovim
    wireguard
    openssl
    quassel
  ];

  environment.shellAliases = { vim = "nvim"; };

  users.users.dev = {
    isNormalUser = true;
    home = "/home/dev";
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [ "${env.SSH_PUBLIC_KEY}" ];
  };

  services.openssh.gatewayPorts = "clientspecified";

  services.cron = {
    enable = true;
    systemCronJobs =
      [ "*/5 *  *  *  *  /root/scripts/free.sh >> /root/scripts/free.log" ];
  };

  services.iodine.server = {
    domain = "${env.IODINE_DOMAIN}";
    enable = true;
    passwordFile = "${env.IODINE_PASSWORD_FILE}";
    ip = "10.0.0.1";
    extraConfig = "-c";
  };

  virtualisation.docker.enable = true;
  users.users.root.extraGroups = [ "docker" ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [
    80
    443
    53
    51820 # wireguard
  ];
  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o bond0 -j MASQUERADE
  '';

  networking.nameservers = [ "1.1.1.1" ];
  networking.extraHosts = ''
    127.0.0.1 localhost
  '';
}
