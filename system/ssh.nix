{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      Macs = [ 
        "hmac-sha2-512"
        "hmac-sha2-256"
        "umac-128@openssh.com"
      ];
    };
  };
  programs.ssh.hostKeyAlgorithms = [ "sk-ssh-ed25519@openssh.com" "ssh-ed25519" ];
}
