{
  flake.modules.nixos.docker = { ... }: {
    virtualisation.docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    # Rootless Docker can't bind ports < 1024 by default. Uncomment if you
    # want e.g. 80/443 published from containers.
    # boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  };
}
