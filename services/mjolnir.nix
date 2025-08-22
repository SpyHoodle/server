{ config, domains, ... }:

{
  services.mjolnir = {
    enable = true;
    accessTokenFile = config.age.secrets.mjolnir.path;

    settings = {
      autojoinOnlyIfManager = true;
      automaticallyRedactForReasons = [ "nsfw" "gore" "spam" "harassment" "hate" ];
      recordIgnoredInvites = true;
      admin.enableMakeRoomAdminCommand = true;
      allowNoPrefix = true;
      protections.wordlist.words = [ ];
      protectedRooms = [ "https://matrix.to/#/#general:${domains.root}" ];
    };

    pantalaimon = {
      enable = false;
      username = "system";
    };
    /*  username = "system";
      options = {
        ssl = false;
        listenAddress = "127.0.0.1";
        listenPort = 8009;
        homeserver = "https://${domains.root}";
      };
    };*/

    homeserverUrl = "http://[::1]:8008";
    managementRoom = "!TMhYTODfkLNJsxCrKO:${domains.root}";
  };
  # services.pantalaimon-headless.instances.mjolnir.listenPort = 8009;
}
