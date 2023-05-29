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
in
{
  completions = {
    keytool = builtins.readFile "${keytool-completions.src}/completions/keytool.fish";
  };

  theme = pure;
}
