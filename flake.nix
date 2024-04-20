{
  description = "Create forms and send notifications from the CLI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let eachSystem = nixpkgs.lib.genAttrs (import inputs.nix-systems);
    in {
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.buildGoModule {
            name = "notify";
            src = ./.;
            vendorHash = "sha256-pyNBOPzzJ+ZcIlGP0DP+MEbQt52XyqJJ/bo+OsmPwUk=";
            meta = with pkgs.lib; {
              description = "Create forms and send notifications from the CLI";
              homepage = "https://github.com/NewDawn0/notify";
              maintainers = with maintainers; [ "NewDawn0" ];
              license = licenses.mit;
            };
          };
        });
    };
}
