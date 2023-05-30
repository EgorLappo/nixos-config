import           XMonad

import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab

main = xmonad $ def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    }
  `additionalKeysP`
  [ ("M-S-l", unGrab *> spawn screenLocker)
  , ("M-p", spawn appLauncher)
  ]

myTerminal    = "alacritty"
myModMask     = mod1Mask

-- borders
myBorderWidth = 3
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#dddddd"

appLauncher  = "rofi -modi drun,ssh,window -show drun -show-icons"
screenLocker = "betterlockscreen -l dim"
