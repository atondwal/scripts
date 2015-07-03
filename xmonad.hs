import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

main = do
     xmproc <- spawnPipe "/usr/bin/xmobar"
     xmonad $ defaultConfig
     	    	    { borderWidth = 2
	    	    , terminal 	= "emacs -Q --load ~/.emacs.d/shell-init.el"
		    , normalBorderColor = "#cccccc"
		    , focusedBorderColor = "#112255"
		    , focusFollowsMouse = False
		    , manageHook = manageDocks <+> manageHook defaultConfig
		    , layoutHook = avoidStruts $ layoutHook defaultConfig
		    , logHook = dynamicLogWithPP xmobarPP
		      { ppOutput = hPutStrLn xmproc
		      ,	ppTitle = xmobarColor "green" "" . shorten 50
		      , ppLayout = const "" -- to disable the layout info on xmobar
		      }
		    , modMask = mod4Mask}
		    `additionalKeysP`
		    [ ("M-e", spawn "emacs")
		    , ("M-f", spawn "firefox")]
