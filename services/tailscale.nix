{ config, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraUpFlags = [
      "--ssh"
      "--accept-routes"
      "--advertise-exit-node"
    ];
    authKeyFile = "${config.age.secrets.tailscale.path}";
  };

  systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = "true";
}
