{ pkgs }:

let
  keytool-completions = {
    name = "keytool-completions";
    src = pkgs.fish-keytool-completions;
  };

  pure = {
    name = "pure-theme";
    src = pkgs.fishPlugins.pure;
  };

  hydro = {
    name = "hydro-theme";
    src = pkgs.fishPlugins.hydro;
  };
in
{
  completions = {
    keytool = builtins.readFile "${keytool-completions.src}/completions/keytool.fish";
  };

  theme = hydro;
}
