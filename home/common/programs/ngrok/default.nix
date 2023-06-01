{ pkgs, lib, ... }:

let
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
