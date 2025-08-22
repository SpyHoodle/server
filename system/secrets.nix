{ ... }:

{
  age.secrets = {
    matrix-synapse = {
      file = ../secrets/matrix-synapse.age;
      owner = "matrix-synapse";
      group = "matrix-synapse";
    };
    matrix-authentication-service = {
      file = ../secrets/matrix-authentication-service.age;
      owner = "matrix-authentication-service";
      group = "matrix-authentication-service";
    };
    mjolnir = {
      file = ../secrets/mjolnir.age;
      owner = "mjolnir";
      group = "mjolnir";
    };
    silverbullet = {
      file = ../secrets/silverbullet.age;
      owner = "silverbullet";
      group = "silverbullet";
    };
    syncplay = {
      file = ../secrets/syncplay.age;
    };
    tailscale = {
      file = ../secrets/tailscale.age;
    };
  };
}
