;; Enable Mouse Support
(xterm-mouse-mode 1)

;; Set to utf8
(set-terminal-coding-system 'utf-8)

;; Set Vertical Separator
(set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│))

(provide 'terminal)
