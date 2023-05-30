import           XMonad

import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab

import           XMonad.Hooks.EwmhDesktops

main = (xmonad . ewmhFullscreen . ewmh) myConfig

myConfig = def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    } `additionalKeysP` myKeybindings

myTerminal    = "alacritty"
myModMask     = mod1Mask

-- borders
myBorderWidth = 3
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#dddddd"

appLauncher  = "rofi -modi drun,ssh,window -show drun -show-icons"
screenLocker = "betterlockscreen -l dim"
screenshot = "shutter -f -o ~/Pictures/screenshots/%Y-%m-%d-%T.png"

myKeybindings =
  [ ("M-S-l", unGrab *> spawn screenLocker)
  , ("M-p", spawn appLauncher)
  , ("M-f", spawn "firefox -P 'default'")
  , ("M-S-t", namedScratchpadAction scratchpads "htop")
  , ("M-S-s", spawn screenshot)
  ]


-- scratchpads

scratchpads =
  [ NS "htop" "alacritty -e htop" (title =? "htop") defaultFloating
  ]
