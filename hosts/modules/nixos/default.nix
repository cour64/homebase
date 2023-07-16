{ pkgs, ... }:

let 
  mainNameservers = [ # We use cloudfront
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  fallbackNameservers = [ # DNSWatch as a fallback
    "84.200.69.80"
    "84.200.70.40"
    "2001:1608:10:25::1c04:b12f"
    "2001:1608:10:25::9249:d69b"
  ];

  coreNetworkConf = {
    networkConfig.DHCP = "yes";
    dns = mainNameservers; # Should fallback to global (systemd-resolved) but just in-case :-)
    dhcpV4Config.UseDNS = false; # config address only, don't use dns from dhcp server
    dhcpV6Config.UseDNS = false; # config address only, don't use dns from dhcp server
  };
in {
  users.defaultUserShell = pkgs.zsh;

  environment.binsh = "${pkgs.dash}/bin/dash";

  # Networking core
  networking.firewall.enable = true;
  networking.dhcpcd.enable = false;

  ## DNS with systemd-resolved
  networking.nameservers = mainNameservers;
  services.resolved = {
    enable = true;
    fallbackDns = mainNameservers;
    dnssec = "true";
    domains = [ "~." ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  ## Network with systemd-networkd
  systemd.network = {
    enable = true;
    networks = {
      wired = {
        matchConfig.Name = "en*";
	networkConfig.DHCP = "yes";
	dns = mainNameservers; # Should fallback to global (systemd-resolved) but just in-case :-)
	dhcpV4Config.UseDNS = false; # config address only, don't use dns from dhcp server
	dhcpV6Config.UseDNS = false; # config address only, don't use dns from dhcp server
      };
      wireless = {
        matchConfig.Name = "wl*";
	networkConfig.DHCP = "yes";
	dns = mainNameservers; # Should fallback to global (systemd-resolved) but just in-case :-)
	dhcpV4Config.UseDNS = false; # config address only, don't use dns from dhcp server
	dhcpV6Config.UseDNS = false; # config address only, don't use dns from dhcp server
      };
    };
  };
}
