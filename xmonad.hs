import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders
import System.IO
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen

myWorkspaces = ["edit", "web", "term", "read", "chat"] ++ map show [6..9]
myManageHook = composeAll . concat $
               [ [ className =? c --> doFloat | c <- cFloats ]
               , [ title =? t --> doFloat | t <- tFloats ]
               , [ isFullscreen --> doFullFloat ]
               , [ className =? "Evince" -->doShift "read"]
               , [ className =? "HipChat" -->doShift "chat"]
               , [ className =? "ScudCloud" -->doShift "chat"]
               , [ className =? "Firefox" -->doShift "web"]]
  where cFloats = ["NES", "tilda"]
        tFloats = ["Firefox Preferences", "Downloads", "Add-ons", "Rename", "Create", "tilda" ]

main = do
     xmproc <- spawnPipe "/usr/bin/xmobar"
     xmonad $ def
                    { borderWidth = 2
                    , terminal  = "emacsclient -c -e '(eshell)'"
                    , workspaces = myWorkspaces
                    , normalBorderColor = "#cccccc"
                    , focusedBorderColor = "#112255"
                    , focusFollowsMouse = False
                    , manageHook = myManageHook <+> manageDocks <+> manageHook def
                    , layoutHook = avoidStruts $ smartBorders $ layoutHook def
                    , handleEventHook = docksEventHook <+> fullscreenEventHook <+> handleEventHook def
                    , logHook = dynamicLogWithPP xmobarPP
                      { ppOutput = hPutStrLn xmproc
                      , ppTitle = xmobarColor "green" "" . shorten 50
                      , ppLayout = const "" -- to disable the layout info on xmobar
                      }
                    , modMask = mod4Mask}
                    `additionalKeysP`
                    [ ("M-e", spawn "emacsclient -c")
                    , ("M-f", spawn "tor-browser")
                    , ("M-c", spawn "hipchat")
                    , ("M-d", spawn "update-monitor")
                    , ("M-b", spawn "next-background")
                    , ("M-s", sendMessage ToggleStruts)
                    , ("XF86AudioRaiseVolume", spawn "amixer -q sset Master 10%+")
                    , ("XF86AudioLowerVolume", spawn "amixer -q sset Master 10%-")]
