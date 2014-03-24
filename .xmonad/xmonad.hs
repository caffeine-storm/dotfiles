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
          ("<XF86AudioMute>", spawn "amixer -q -D pulse sset Master toggle"),
          ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 1- unmute"),
          ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 1+ unmute"),
          ("<XF86AudioPlay>", spawn "bash -c 'if [[ \"$(mpc current)\"x == \"x\" ]]; then mpc -q play ; else mpc -q stop; fi ;'"),
          ("<XF86AudioPrev>", spawn "mpc -q prev"),
          ("<XF86AudioNext>", spawn "mpc -q next")
        ]) {
        modMask = mod4Mask,
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
        logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 100
        }
    }

