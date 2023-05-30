# my `nixos` config

### XMonad Layout

Two main details. First, `Alt-Space` switches between two versions: simple regular tiled version, and the grid layout. **However**, for single window configs, regular tiled goes full screen, while the grip layout keeps the window centered in the middle. Additionally, `Alt-f` **always** toggles full screen mode.

### Other XMonad keys

* `Alt-w` launches Chromium (w for "web")
* `Alt-p` launches `rofi`
* `Alt-Shift-l` locks the screen
* `Alt-Shift-t` launches `htop` in a scratchpad window
* `Alt-Shift-s` launches a screenshot tool

### Commands

* `nswitch` is an alias for `nixos-rebuild switch` with all the arguments
* `hswitch` works similarly, but for `home-manager switch`

### Programs

* `bat` instead of `cat`, `rg` instead of `grep`

