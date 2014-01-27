import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)

import System.IO

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad =<< xmobar (defaultConfig `additionalKeysP` [
          ("<XF86AudioMute>", spawn "amixer -q set Master toggle"),
          ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 1- unmute"),
          ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 1+ unmute") 
        ]) {
        modMask = mod4Mask,
        startupHook = setWMName "LG3D",
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 100
        }
    }

