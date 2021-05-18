{ pkgs, ... }:

{
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  environment = {
    systemPackages = with pkgs; [ tailscale vim ];
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      # thomas: Auth keys are only required once for provisioning. Once
      # provisioned, tailscaled should rotate the key automatically.
      ${tailscale}/bin/tailscale up -authkey tskey-invalid
    '';
  };

  users = {
    mutableUsers = false;
    users.root = {
      hashedPassword = null;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl1I1pRdzE7JjGZdyx2RDOmhxU1fJBRvR1lv6e2tyhk automata@starjunk.net"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvCAVkOy8Onb9xHl1mLV2+RSH1jV/tGLu7zGRCCdomF thomas@Cappuccino"
      ];
    };
  };

  virtualisation.cri-o = {
    enable = true;
    # extraPackages = with pkgs; [ gvisor ];
    # runtime = [ "crun" ];
  };
}
