{ domains, ... }:

let
  clientConfig = {
    "m.homeserver".base_url = "https://${domains.root}";
    "org.matrix.msc2965.authentication" = {
      "issuer" = "https://${domains.auth}";
      "account" = "https://${domains.auth}/account";
    };
  };
  serverConfig = {
    "m.server" = "${domains.root}";
  };
  mkWellKnown = data: ''
    add_header Content-Type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  services.nginx = {
    clientMaxBodySize = "100m";
    virtualHosts = {
      "${domains.root}" = {
        enableACME = true;
        forceSSL = true;

        locations."=/.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
        locations."=/.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;

        locations = {
          "~ ^/_matrix/client/(.*)/(login|logout|refresh)" = {
            priority = 100;
            proxyPass = "http://0.0.0.0:8080";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
          "~ ^(/_matrix|/_synapse/client)" = {
            priority= 200;
            proxyPass = "http://[::1]:8008";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header X-Forwarded-For $remote_addr;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header Host $host;
              proxy_buffering off;
            '';
          };
        };

        listen = [
          {
            addr = "[::1]";
            port = 443;
            ssl = true;
          }
          {
            addr = "0.0.0.0";
            port = 443;
            ssl = true;
          }
          {
            addr = "0.0.0.0";
            port = 8448;
            ssl = true;
            extraParameters = [ "default_server" ];
          }
        ];
      };
      "${domains.auth}" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://0.0.0.0:8080";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          '';
        };

        listen = [
          {
            addr = "[::1]";
            port = 443;
            ssl = true;
          }
          {
            addr = "0.0.0.0";
            port = 443;
            ssl = true;
          }
        ];
      };
    };
  };
}
