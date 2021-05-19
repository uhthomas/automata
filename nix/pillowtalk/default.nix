{ name, nodes, pkgs, ... }:
{
  imports = [ (./. + "/${name}") ];

  deployment = {
    targetHost = "${name}.starjunk.net.beta.tailscale.net";
    tags = [ "pillowtalk" ];
  };

  networking.hostName = name;
}
