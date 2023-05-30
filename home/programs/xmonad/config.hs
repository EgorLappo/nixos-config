import           XMonad

import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab

import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers

import           XMonad.Actions.SpawnOn

-- import for scratchpad
import qualified XMonad.StackSet             as W
import           XMonad.Util.NamedScratchpad

-- imports for polybar
import qualified Codec.Binary.UTF8.String    as UTF8
import qualified DBus                        as D
import qualified DBus.Client                 as D
import           XMonad.Hooks.DynamicLog

main :: IO ()
main = mkDbusClient >>= main'

main' :: D.Client -> IO ()
main' dbus = (xmonad . docks . ewmhFullscreen . ewmh) myConfig
 where
    myConfig = def
      { terminal    = myTerminal
      , modMask     = myModMask
      , manageHook  = manageHook def <+> myManageHook
      , logHook     = myPolybarLogHook dbus
      , borderWidth = myBorderWidth
      , normalBorderColor  = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      } `additionalKeysP` myKeybindings

myTerminal    = "alacritty"
myModMask     = mod1Mask
myManageHook  = (namedScratchpadManageHook scratchpads) <+> manageSpawn <+> hookList
  where hookList = composeAll [ isDialog --> doFloat ]

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
  [ NS "htop" "alacritty --class=htop -e htop" (resource =? "htop") (customFloating $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
  ]

-- Polybar

mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#7AA2F7"
      gray   = "#7F7F7F"
      orange = "#E0AF68"
      purple = "#AD8EE6"
      red    = "#F7768E"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = wrapper purple . shorten 90
          }

myLogHook = fadeInactiveLogHook 0.9
myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)
