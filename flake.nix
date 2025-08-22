{
  description = "Configuration for my NixOS home server, lambda";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs-unstable";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs-unstable, agenix, deploy-rs }:
    let
      root_domain = "spyhoodle.me";
      hostname = "phobos";
      tailnet = "mermaid-elevator.ts.net";
      system = "aarch64-linux";
      pkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "olm-3.2.16"
        ];
      };
    in
    {
      packages.${system} = {
        nixosConfigurations.${hostname} = nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = {
            inherit hostname;
            domains = {
              root = "${root_domain}";
              git = "git.${root_domain}";
              ssh = "${hostname}.${tailnet}";
              auth = "auth.${root_domain}";
              notes = "notes.${root_domain}";
            };
          };
          modules = [
            # Services Modules
            ./services/acme.nix
            ./services/website.nix
            ./services/matrix-nginx.nix
            ./services/matrix-synapse.nix
            ./services/matrix-authentication-service.nix
            ./services/mjolnir.nix
            ./services/gitea.nix
            ./services/nginx.nix
            ./services/syncplay.nix
            ./services/postgresql.nix
            ./services/tailscale.nix
            ./services/silverbullet.nix

            # Custom Modules
            ./modules/matrix-authentication-service.nix
            ./modules/tailscale-clicks.nix

            # Agenix
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages.${system}.default ]; }

            # System Modules
            ./system/ssh.nix
            ./system/users.nix
            ./system/zsh.nix
            ./system/locale.nix
            ./system/gpg.nix
            ./system/nix.nix
            ./system/nixos.nix
            ./system/doas.nix
            ./system/hardware.nix
            ./system/audio.nix
            ./system/bluetooth.nix
            ./system/boot.nix
            ./system/networking.nix
            ./system/firewall.nix
            ./system/packages.nix
            ./system/secrets.nix
          ];
        };
      };

      deploy.nodes.${hostname} = {
        hostname = "${hostname}.${tailnet}";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${hostname};
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
      formatter.${system} = nixpkgs-unstable.legacyPackages.${system}.nixpkgs-fmt;
    };
}
