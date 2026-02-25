{ config, pkgs, ... }:

{
  # Enable docker
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = ["8.8.8.8" "1.1.1.1"];
      "live-restore" = true;
    };
  };

  # Enable tailscale daemon
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  # Minecraft server
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

   package = pkgs.papermcServers.papermc-1_21_10;

    serverProperties = {
      server-ip = "100.120.226.4";
      server-port = 26565;
      difficulty = "normal";
      gamemode = "survival";
      max-players = 4;

      sync-chunk-writes = false;

      online-mode = false;
      };
   };

  # Caddy service for website
  services.caddy = {
    enable = true;
    virtualHosts."100.120.226.4" = {
      extraConfig = ''
        root * /var/www/dashboard
        file_server
        header {
          # Optional: Security headers for that Apple-clean feel
          Strict-Transport-Security "max-age=31536000;"
          X-Content-Type-Options nosniff
          X-Frame-Options DENY
        }
      '';
    };
  };
}
