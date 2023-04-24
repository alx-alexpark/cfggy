{ pkgs, ...}:
{
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/srv"
      "/var/lib"
      "/var/log"
      "/var/db/dhcpcd"
      "/etc/NetworkManager"
      "/media"
      "/etc/udev/rules.d"
      "/root"
      "/etc/secureboot"
      "/etc/wireguard"
    ];
  };
}
