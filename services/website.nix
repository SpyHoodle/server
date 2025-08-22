{ domains, ... }:

{
  services.nginx.virtualHosts."${domains.root}" = {
    forceSSL = true;
    enableACME = true;
    root = "/var/www/spyhoodle.me";
  };
}
