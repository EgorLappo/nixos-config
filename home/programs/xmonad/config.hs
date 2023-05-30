import           XMonad

import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Ungrab

import           XMonad.Hooks.EwmhDesktops

import           XMonad.Actions.SpawnOn

import qualified XMonad.StackSet             as W

main = (xmonad . ewmhFullscreen . ewmh) myConfig

myConfig = def
    { terminal    = myTerminal
    , modMask     = myModMask
    , manageHook  = myManageHook
    , borderWidth = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    } `additionalKeysP` myKeybindings

myTerminal    = "alacritty"
myModMask     = mod1Mask
myManageHook  = (namedScratchpadManageHook scratchpads) <+> manageSpawn <+> manageHook def

-- borders
myBorderWidth = 3
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#dddddd"

appLauncher  = "rofi -modi drun,ssh,window -show drun -show-icons"
screenLocker = "betterlockscreen -l dim"
screenshot = "scrot -s -f '%Y-%m-%d_%H-%M-%S.png' -e 'mv $f ~/Pictures/screenshots/'"

myKeybindings =
  [ ("M-S-l", spawn screenLocker)
  , ("M-p", spawn appLauncher)
  , ("M-f", spawn "firefox -P 'default'")
  , ("M-S-t", namedScratchpadAction scratchpads "htop")
  , ("M-S-s", unGrab *> spawn screenshot)
  ]


-- scratchpads
-- https://eyenx.ch/2020/05/02/using-named-scratchpads-with-xmonad/
scratchpads =
  [ NS "htop" "alacritty -e htop" (title =? "htop") defaultFloating --(customFloating $ W.RationalRect (2/6) (2/6) (2/6) (2/6))
  ]
