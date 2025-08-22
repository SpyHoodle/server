{ pkgs, ... }:

{
  users.users.maddie = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Madeleine";
    openssh.authorizedKeys.keyFiles = [ ./ssh/maddie.pub ];
  };
  users.users.evelyne = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Evelyne";
    openssh.authorizedKeys.keyFiles = [ ./ssh/evelyne.pub ];
  };
}
