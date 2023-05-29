import           XMonad

main = do
  xmonad $ def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    }

myTerminal    = "alacritty"
myModMask     = mod1Mask -- Win key or Super_L
myBorderWidth = 3
