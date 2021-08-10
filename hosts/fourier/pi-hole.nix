{
  networking.firewall = {
    allowedTCPPorts = [ 80 53 ];
    allowedUDPPorts = [ 53 ];
  };

  virtualisation.oci-containers.containers.pi-hole = {
    autoStart = true;
    image = "pihole/pihole:dev";
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "80:80/tcp"
    ];
    volumes = [
      "/etc/pihole/:/etc/pihole/"
      "/etc/dnsmasq.d/:/etc/dnsmasq.d/"
    ];
    environment = {
      CUSTOM_CACHE_SIZE = "0";
      DNSSEC = "false";
      PIHOLE_DNS_ = "127.0.0.1#5335";
      REV_SERVER = "true";
      REV_SERVER_CIDR = "10.0.0.0/24";
      REV_SERVER_DOMAIN = "localdomain";
      REV_SERVER_TARGET = "10.0.0.1";
      ServerIP = "10.0.0.3";
      ServerIPv6 = "fe80::1ac0:4dff:fe31:c5f";
      TZ = "America/Los_Angeles";
      WEBPASSWORD = "3zKgwWMYJd36xo2uO5glT7Nx";
      WEBTHEME = "default-darker";
    };
    extraOptions = [ "--network=host" ];
  };
}