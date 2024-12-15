{
  description = "Create forms and send notifications from the CLI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      overlays.default =
        (final: prev: { notify = self.packages.${prev.system}.default; });
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.buildGoModule {
            pname = "notify";
            version = "1.0.0";
            src = ./.;
            vendorHash = "sha256-pyNBOPzzJ+ZcIlGP0DP+MEbQt52XyqJJ/bo+OsmPwUk=";
            meta = {
              description =
                "A command-line utility for creating forms and sending notifications";
              longDescription = ''
                This tool enables users to create customizable forms and send notifications directly from the command line. It's useful for automating repetitive tasks and handling user inputs easily.
              '';
              homepage = "https://github.com/NewDawn0/notify";
              license = pkgs.lib.licenses.mit;
              maintainers = with pkgs.lib.maintainers; [ NewDawn0 ];
              platforms = pkgs.lib.platforms.all;
            };
          };
        });
    };
}
