{
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "maddie" ];
      keepEnv = true;
      persist = true;
    }];
  };
}
