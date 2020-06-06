let env = import ./env.nix;
in {
  network = {
    description = "nixos-server";
    enableRollback = true;
  };

  defaults = { imports = [ ./common.nix ]; };

  server = { config, pkgs, ... }: {
    deployment.targetHost = "${env.TARGET_HOST}";

    imports = [
      ./config/server/nixos/configuration.nix
      ./services/phoenix-blog.nix
      ./services/quassel-core.nix
      ./services/wireguard.nix
    ];
  };
}
