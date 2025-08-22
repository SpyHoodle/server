{
  # Configure automated TLS acquisition/renewal
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "maddie@spyhoodle.me";
    };
  };

  # ACME data must be readable by the NGINX user
  users.users.nginx.extraGroups = [
    "acme"
  ];
}
