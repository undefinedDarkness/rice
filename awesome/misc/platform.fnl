(import-macros {: buttons} :misc.macros)
(local gears (require :gears))
(local awful (require :awful))

;; Setup Tiled Wallpaper
(let [bling (require :misc.libs.bling)]
  (screen.connect_signal 
    "request::wallpaper" 
    (fn [s]         
      (bling.module.tiled_wallpaper "♜" s  
                                  {:fg "#ea9d34"
                                   :bg "#faf4ed"
                                   :offset_y 25
                                   :offset_x 45
                                   :font "UnifontMedium Nerd Font"
                                   :font_size 23
                                   :padding 100
                                   :zickzack true}))))

;; Setup Tags
(screen.connect_signal
  "request::desktop_decoration"
  (fn [s]
    (awful.tag [ "Hephaestus" "Apollo" "Hermes" ] s (. awful.layout.layouts 1))))

;; Root Window Buttons
(root.buttons (buttons
                [ mouse.RIGHT (require :subcomponents.menu)]
                [ mouse.SCROLL_UP awful.tag.viewnext]
                [ mouse.SCROLL_DOWN awful.tag.viewprev]))
                          
(let [ raise (fn [c] (c:emit_signal "request::activate" "mouse_click" { :raise true}))]
  (local clientbuttons (buttons
                         [ MOD mouse.LEFT raise]
                         [ MOD mouse.LEFT (fn [c]
                                           (raise)
                                           (awful.mouse.client.move c))]
                         [ MOD mouse.RIGHT (fn [c]
                                            (raise)
                                            (awful.mouse.client.resize c))])))
(let [ beautiful (require :beautiful)]
  (set awful.rules.rules [
                          ;; Basic Client Rules
                          {
                           :rule []
                           :properties {:border_width beautiful.border_width
                                        :border_color beautiful.border_normal
                                        :focus awful.client.focus.filter
                                        :raise true
                                        ;; :keys (require :misc.keybindings.client)
                                        :buttons clientbuttons
                                        :screen awful.screen.preferred
                                        :placement (+ awful.placement.no_overlap awful.placement.no_offscreen)}}
                          ;; Titlebars for prompts and normal windows 
                          {:rule_any {
                                      :type [ "normal" "dialog"]}
                           :properties {
                                        :titlebars_enabled true}}
                          ;; Disable Titlebars For GNOME Apps With CSD Titlebars
                          {:rule_any {
                                      :class [
                                              "Mizer"
                                              "Gnome-font-viewer"
                                              "File-roller"
                                              "Nautilus"
                                              "Myxer"
                                              "Eog"
                                              "Evince"
                                              "Gedit"
                                              "Gnome-calculator"]}
                           :properties { :titlebars_enabled false}}]))
                                     
(client.connect_signal) "manage" 
(fn [c]
    (when (and 
            awesome.startup 
            (not c.size_hints.user_position) 
            (not c.size_hints.progam_position)) 
      ((+ (awful.placement.no_overlap) (awful.placement.no_offscreen)) c)))  
