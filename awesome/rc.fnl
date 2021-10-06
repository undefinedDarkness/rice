;  _______                                            
; |   _   |.--.--.--.-----.-----.-----.--------.-----.
; |       ||  |  |  |  -__|__ --|  _  |        |  -__|
; |___|___||________|_____|_____|_____|__|__|__|_____|

(pcall require :luarocks.loader)

;; Set Configuration Directory
(let [gears (require :gears)]
  (global _config_dir (gears.filesystem.get_dir "config")))

;; Init Beautiful
(let [beautiful (require :beautiful)]
  (global dpi beautiful.xresources.apply_dpi)
  (beautiful.init (.. _config_dir "/theme/theme.lua")))
 
;; Set Mouse Keys
(set mouse.LEFT 1)
(set mouse.MIDDLE 2)
(set mouse.RIGHT 3)
(set mouse.SCROLL_UP 4)
(set mouse.SCROLL_DOWN 5)
(global MOD "Mod1")

;; Require Built-in modules
(require :awful.hotkeys_popup.keys)
(require :awful.autofocus)

;; Load User Modules
(require :misc.platform)
; (require :components.titlebar)
; (require :components.notifications)
; (require :misc.keybindings.global)

(print "\n🧅 Running Fennel Config\n")
