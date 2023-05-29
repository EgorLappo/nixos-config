{ pkgs, lib, ... }:

let
  # token = lib.secretManager {
  #   filepath = ../../secrets/ngrok-token;
  #   fileAction = file: lib.removeNewline (builtins.readFile file);
  #   encryptedSha256 = "c09ec94f0ce53f889cf4f26576f238371ce5f7c761d3420e1b886934b0b04eaf";
  #   emptyValue = "SECRET";
  # };

  # YAML is a superset of JSON...
  ngrokConfig = builtins.toJSON {
    version = 2;
    # authtoken = token;
  };
in
{
  # secure tunneling to localhost
  home.packages = [ pkgs.ngrok ];

  xdg.configFile."ngrok/ngrok.yml".text = ngrokConfig;
}
