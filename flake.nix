{
  description = "Create forms and send notifications from the CLI";

  inputs.utils.url = "github:NewDawn0/nixUtils";

  outputs = { self, utils, ... }: {
    overlays.default = final: prev: {
      notify = self.packages.${prev.system}.default;
    };
    packages = utils.lib.eachSystem { } (pkgs: {
      default = pkgs.buildGoModule {
        name = "notify";
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
