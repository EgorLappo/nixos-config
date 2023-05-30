import           XMonad

import           XMonad.Util.Cursor
import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab

import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.FadeInactive
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.WindowSwallowing

import           XMonad.Actions.SpawnOn

import           XMonad.Layout.CenteredIfSingle
import           XMonad.Layout.Grid
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing

-- import for scratchpad
import qualified XMonad.StackSet                     as W
import           XMonad.Util.NamedScratchpad

-- imports for polybar
import qualified Codec.Binary.UTF8.String            as UTF8
import qualified DBus                                as D
import qualified DBus.Client                         as D
import           XMonad.Hooks.DynamicLog

import qualified XMonad.Util.Hacks                   as Hacks

main :: IO ()
main = mkDbusClient >>= main'

main' :: D.Client -> IO ()
main' dbus = (xmonad . docks . ewmhFullscreen . ewmh) myConfig
 where
    myConfig = def
      { terminal    = myTerminal
      , modMask     = myModMask
      -- manage hook takes care of scratchpad windows
      , manageHook  = manageHook def <+> myManageHook
      , layoutHook  = myLayoutHook
      -- log hook for polybar, following https://github.com/gvolpe/nix-config/
      , logHook     = myPolybarLogHook dbus
      -- set normal cursor, not the "X" one
      , startupHook = setDefaultCursor xC_left_ptr
      -- this event hook has 1) some hack for chromium apps 2) window swallowing
      , handleEventHook = myHandleEventHook
      -- borders
      , borderWidth = myBorderWidth
      , normalBorderColor  = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      -- no focus change on mouse movement
      , focusFollowsMouse = False
      } `additionalKeysP` myKeybindings

myTerminal    = "alacritty"
myModMask     = mod1Mask
myManageHook  = (namedScratchpadManageHook scratchpads) <+> manageSpawn <+> hookList
  where hookList = composeAll [ isDialog --> doFloat ]
myHandleEventHook = Hacks.windowedFullscreenFixEventHook <+> (swallowEventHook (className =? "Alacritty") (return True)) <+> handleEventHook def

-- borders
myBorderWidth = 2
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#777777"

appLauncher  = "rofi -modi drun,ssh,window -show drun -show-icons"
screenLocker = "betterlockscreen -l dim"
screenshot = "scrot -s -f '%Y-%m-%d_%H-%M-%S.png' -e 'mv $f ~/Pictures/screenshots/'"

myKeybindings =
  [ ("M-S-l", spawn screenLocker)
  , ("M-p", spawn appLauncher)
  , ("M-w", spawn "chromium")
  , ("M-S-t", namedScratchpadAction scratchpads "htop")
  , ("M-S-s", unGrab *> spawn screenshot)
  , ("M-f", sendMessage $ Toggle FULL)
  ]

myLayoutHook = smartBorders . smartSpacing 5 . avoidStruts . mkToggle (NOBORDERS ?? FULL ?? EOT) $ (centeredIfSingle 0.7 0.8 tiled ||| centeredIfSingle 0.7 0.8 Grid)
    --centeredIfSingle 0.7 0.8 tiled ||| centeredIfSingle 0.7 0.8 (Mirror tiled) ||| centeredIfSingle 0.7 0.8 Grid ||| Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100

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
