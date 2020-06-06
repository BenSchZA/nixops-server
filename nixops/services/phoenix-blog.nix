{ pkgs, ... }:

{
  systemd.services.phoenix-blog = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start Phoenix/Elixir application";
    environment = {
      MIX_ENV = "prod";
      LANG = "en_US.UTF-8";
      PORT = "4002";
    };
    serviceConfig = {
      Type = "simple";
      User = "dev";
      Restart = "on-failure";
      RestartSec = "5";
      StartLimitBurst = "3";
      StartLimitInterval = "10";
      WorkingDirectory = "/var/apps/phoenix-blog";
      ExecStart = "/var/apps/phoenix-blog/_build/prod/rel/app/bin/app start";
      ExecReload = "/var/apps/phoenix-blog/_build/prod/rel/app/bin/app restart";
      ExecStop = "/var/apps/phoenix-blog/_build/prod/rel/app/bin/app stop";
      EnvironmentFile = "/var/apps/phoenix-blog/.envrc";
    };
  };
}
