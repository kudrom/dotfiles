
import XMonad
import Data.Monoid
import Data.List
import Data.Ratio ((%))
import System.Exit
import System.IO
import System.Environment
import System.Directory
import System.IO.Unsafe

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook

import XMonad.Layout.NoBorders
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid

import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.CycleWS

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--Soporte para java
import XMonad.Hooks.SetWMName

------------------------------------------------------------------------
--General Config

myTerminal      = "terminator"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 2
myModMask       = mod4Mask
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
--Workspaces

myWorkspaces=
	[
	 " ^i(/home/kudrom/.xmonad/icons/coding.xbm) head "
	," ^i(/home/kudrom/.xmonad/icons/mail.xbm) mail"
	," ^i(/home/kudrom/.xmonad/icons/fox.xbm) rss"
	," ^i(/home/kudrom/.xmonad/icons/note.xbm) music"
	," ^i(/home/kudrom/.xmonad/icons/blender.xbm) blender"
	," ^i(/home/kudrom/.xmonad/icons/gimp.xbm) gimp"
	," ^i(/home/kudrom/.xmonad/icons/chat.xbm) chat"
	," ^i(/home/kudrom/.xmonad/icons/pacman.xbm) code"
	," ^i(/home/kudrom/.xmonad/icons/coding.xbm) tail "
	]

------------------------------------------------------------------------
--Key and Mouse Bindings

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm,				xK_a	 ), spawn $ XMonad.terminal conf)
    , ((modm,				xK_e	 ), spawn "geany")
    , ((modm,				xK_g	 ), spawn "gimp")
    , ((modm,				xK_w	 ), spawn "chromium")
    , ((modm .|. shiftMask, xK_w     ), spawn "firefox")
    , ((modm,				xK_f	 ), spawn "pcmanfm")
    , ((modm,				xK_b	 ), spawn "blender")
    , ((modm,				xK_v	 ), spawn "vlc")
    , ((modm,				xK_c	 ), spawn "gsimplecal")
    , ((modm,				xK_ntilde), spawn "xscreensaver-command -lock")
	, ((modm,				xK_Up	 ), spawn "transset-df -a --inc 0.1")
	, ((modm,				xK_Down  ), spawn "transset-df -a --dec 0.1")
	, ((modm,				xK_p	 ), nextScreen)
    , ((0, 0x1008ff32		 		 ), spawn "exaile")
    , ((0, 0x1008ff17		 		 ), spawn "exaile -n")   
    , ((0, 0x1008ff16		 		 ), spawn "exaile -p")   
    , ((0, 0x1008ff15		 		 ), spawn "exaile -t")    
    , ((0, 0x1008ff1d				 ), spawn "terminator -x calc")
    , ((0, 0x1008ff4a				 ), spawn "pavucontrol")
    , ((0,					xK_Print ), spawn "scrot '%d-%m-%Y.png' -e 'mv $f /home/kudrom/datos/imagenes/capturas/'")
    , ((shiftMask,			xK_Print ), spawn "scrot -s '%d-%m-%Y.png' -e 'mv $f /home/kudrom/datos/imagenes/capturas/'")
    , ((modm,               xK_F3    ), spawn "dmenu_path_c | dmenu_run -nb '#000000' -nf '#d9d9d9' -sb '#ff7300' -sf '#ffffff' -b")
	, ((0, 0x1008ff2f				 ), spawn "systemctl poweroff")
	, ((modm, 0x1008ff2f				 ), spawn "systemctl reboot")
    , ((modm, 				xK_z     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm,				xK_Right ), nextWS)
    , ((modm,				xK_Left  ), prevWS)
    , ((modm .|. shiftMask,	xK_Right ), shiftToNext)
    , ((modm .|. shiftMask,	xK_Left ), shiftToPrev)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapUp  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapDown    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm              , xK_s     ), sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]
    
------------------------------------------------------------------------
--Layouts

myLayout = avoidStruts $ onWorkspace " ^i(/home/kudrom/.xmonad/icons/chat.xbm) chat" imLayout $ noBorders (Full) ||| tiled
	where
		imLayout = 	avoidStruts $
					withIM (1%5) (Role "buddy_list") Grid
		tiled   = Tall nmaster delta ratio
		nmaster = 1
		ratio   = 1/2
		delta   = 3/100

------------------------------------------------------------------------
--Hooks

myManageHook = composeAll
    [isDialog						--> doFloat
    , className =? "Gsimplecal"		--> doFloat
    , stringProperty "WM_ICON_NAME" =? "/usr/bin/calc"	--> doFloat
    , title =? "Downloads"			--> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Blender"		--> doShift (" ^i(/home/kudrom/.xmonad/icons/blender.xbm) blender")
    , title =? "Blender User Preferences"--> doFloat
    , className =? "Thunderbird"	--> doShift (" ^i(/home/kudrom/.xmonad/icons/mail.xbm) mail")
    , title =? "Thunderbird Preferences"--> doFloat
    , className =? "Liferea"		--> doShift (" ^i(/home/kudrom/.xmonad/icons/fox.xbm) rss")
    , className =? "Gimp" <||> resource =? "Gimp" <||> title =? "Gimp"		--> doShift ("^p(5)^i(/home/kudrom/.xmonad/icons/gimp.xbm) gimp")
    , className =? "Pidgin"			--> doShift (" ^i(/home/kudrom/.xmonad/icons/chat.xbm) chat")
    , className =? "exaile.py"          --> doShift(" ^i(/home/kudrom/.xmonad/icons/music.xbm) music")
    ] 
    
------------------------------------------------------------------------
-- Event handling

myEventHook = docksEventHook
myStatusBar = "dzen2 -x '0' -y '0' -h '20' -w '850' -ta 'l' -fg '#ffffff' -fn -adobe-helvetica-medium-*-normal-*-12-*-*-*-p-0-iso8859-1"
myDzenPP h = defaultPP
	{ ppSep = ""
	, ppWsSep = " "
	, ppOutput = hPutStrLn h
	, ppCurrent = wrap ("") (""). \ws1 -> "^bg(#ff7300)^fg(#ffffff)"++ws1
	, ppHidden = wrap ("") (""). \ws1 -> "^bg(#707070)^fg(#0090ff)"++ws1
	, ppVisible = wrap ("") (""). \ws1 ->"^bg(#0E8E04)^fg(#ffffff)"++ws1
	, ppHiddenNoWindows = wrap ("") (""). \ws1 -> "^bg(#000000)^fg(#ffffff)"++ws1
	, ppUrgent = wrap ("") (""). \ws1 -> "^bg(#ff0000)^fg(#ffffff)"++ws1
	, ppTitle = wrap ("") (""). \tt -> "^bg(#000000)^p(25)^fg(#d2d2d2)"++tt
	, ppLayout = wrap ("") (""). \ly -> ""
	}
	
conkyBar = do 
        fileExists <- doesFileExist "/sys/class/hwmon/hwmon0/fan1_label"
        if fileExists
            then return "conky -c /home/kudrom/.config/conky/conkytop0"
            else return "conky -c /home/kudrom/.config/conky/conkytop1"

conky = unsafePerformIO conkyBar

myTopBar = conky ++ " | dzen2 -x '850' -y '0' -h '20' -w '830' -ta 'r' -fg '#ffffff' -fn -adobe-helvetica-medium-*-*-*-12-*-*-*-p-*-iso8859-1"

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = setWMName "LG3D"

main = do
	dzen <- spawnPipe myStatusBar
	conkytop <- spawnPipe myTopBar
	xmonad $ defaultConfig {
        startupHook        = myStartupHook,
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

		layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ myDzenPP dzen
    }
