{
  defaults = ./defaults.nix;

  "5dc508ed7c" = { name, nodes, ... }: {
    imports = [ ./pillowtalk/5dc508ed7c ];

    deployment = {
      targetHost = "${name}.starjunk.net.beta.tailscale.net";
      tags = [ "pillowtalk" ];
    };

    networking.hostName = name;
  };

  d9294fd26f = { name, nodes, ... }: {
    imports = [ ./pillowtalk/d9294fd26f ];

    deployment = {
      targetHost = "${name}.starjunk.net.beta.tailscale.net";
      tags = [ "pillowtalk" ];
    };

    networking.hostName = name;
  };

  "44fe941f5c" = { name, nodes, ... }: {
    imports = [ ./pillowtalk/44fe941f5c ];

    deployment = {
      targetHost = "${name}.starjunk.net.beta.tailscale.net";
      tags = [ "pillowtalk" ];
    };

    networking.hostName = name;
  };

  c28593b8bf = { name, nodes, ... }: {
    imports = [ ./pillowtalk/c28593b8bf ];

    deployment = {
      targetHost = "${name}.starjunk.net.beta.tailscale.net";
      tags = [ "pillowtalk" ];
    };

    networking.hostName = name;
  };

  f0b8e3e4f7 = { name, nodes, ... }: {
    imports = [ ./pillowtalk/f0b8e3e4f7 ];

    deployment = {
      targetHost = "${name}.starjunk.net.beta.tailscale.net";
      tags = [ "provision" "pillowtalk" ];
    };

    networking.hostName = name;
  };
}
