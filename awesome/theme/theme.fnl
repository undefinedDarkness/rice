(let [assets (.. _config_dir "/theme/assets")]
  {
   ;; TODO: Use theme variables a lot more!
   :transparent "#00000000"
   :useless_gap (dpi 8)
   :notification_spacing (dpi 16)
   :wallpaper (.. assets "wallpaper.png")
   :layout_floating (.. assets "layouts/floating.png")
   :layout_tile (.. assets "layouts/tile.png")
   :layout_dwindle (.. assets "layouts/dwindle.png")}) 
