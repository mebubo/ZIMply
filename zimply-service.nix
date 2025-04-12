{ config, lib, pkgs }:

with lib;

let
  cfg = config.services.zimply;

  projectRoot = ./.;
  mainScript = "${projectRoot}/main.py";
  templatePath = "${projectRoot}/zimply/template.html";
  stateDirName = "zimply";
  indexDirPath = "/var/lib/${stateDirName}";

  userName = "zimply";
  groupName = "zimply";

  zimplyPythonEnv = pkgs.python3.withPackages (ps: with ps; [
    gevent
    falcon
    mako
    zstandard
  ]);

in
{
  options.services.zimply = {
    enable = mkEnableOption "ZIMply web server";

    zimPath = mkOption {
      type = types.path;
      description = "Path to the directory containing ZIM files.";
      example = "/var/lib/zim";
    };

    ipAddress = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "IP address the ZIMply server should bind to.";
      example = "127.0.0.1";
    };

    port = mkOption {
      type = types.port;
      default = 8081;
      description = "Port the ZIMply server should listen on.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      { assertion = builtins.pathExists templatePath;
        message = "ZIMply service: Required template file '${templatePath}' does not exist.";
      }
      { assertion = builtins.pathExists cfg.zimPath;
        message = "ZIMply service: zimPath '${toString cfg.zimPath}' does not exist or is not accessible.";
      }
    ];

    users.users.${userName} = {
      isSystemUser = true;
      group = groupName;
      home = indexDirPath;
    };
    users.groups.${groupName} = {};

    systemd.services.zimply = {
      description = "ZIMply ZIM File Server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      environment.PYTHONPATH = "${projectRoot}";

      serviceConfig = {
        User = userName;
        Group = groupName;
        Restart = "always";

        StateDirectory = stateDirName;

        ExecStart = ''
          ${zimplyPythonEnv}/bin/python ${mainScript} \
            --zim-path ${cfg.zimPath} \
            --index-dir ${indexDirPath} \
            --template ${templatePath} \
            --ip ${cfg.ipAddress} \
            --port ${toString cfg.port}
        '';

      };
    };
  };
}
