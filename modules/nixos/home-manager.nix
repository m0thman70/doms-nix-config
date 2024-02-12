{ config, lib, inputs, self, ... }:
let
  inherit (lib)
    mapAttrs
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  userSubmodule = types.submodule {
    options = {
      enable = mkEnableOption "Enable home-manager per user";

      extraHomeConfig = mkOption {
        type = types.attrs;
        default = { };
      };
    };
  };

  cfg = config.reprod.hm;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.reprod.hm = {
    enable = mkEnableOption "Enable home-manager globally";
    extraHomeConfig = mkOption {
      type = types.attrs;
      default = { };
    };

    users = mkOption {
      type = types.attrsOf userSubmodule;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home-manager.extraSpecialArgs = { inherit inputs self; };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users = mapAttrs
      (name: user: mkIf user.enable (mkMerge [
        cfg.extraHomeConfig
        user.extraHomeConfig
        {
          imports = [
            ../home
	    ../../home
          ];
          programs.home-manager.enable = true;
        }
      ]))
      cfg.users;
  };
}
