{ name, ... }:
{
  imports = [ (./. + "/${name}") ];

  deployment = {
    targetHost = "${name}.starjunk.net.beta.tailscale.net";
    tags = [ "pillowtalk" ];
  };

  networking.hostName = name;

  virtualisation.cri-o = {
    enable = true;
    # extraPackages = with pkgs; [ gvisor ];
    runtime = "crun";
  };

  services.iperf3 = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.allowedUDPPorts = [ 5201 ];
}
