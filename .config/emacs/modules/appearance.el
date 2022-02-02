;; -*- lexical-binding: t; -*-
;; Appearance

(pixel-scroll-precision-mode 1) ;; Good Scrolling
(fringe-mode -1)

;; Font
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono Liga-12"))

;; Window Padding
(add-to-list 'default-frame-alist '(internal-border-width . 24))

;; Hide Line Truncation Symbol
(set-display-table-slot standard-display-table 'truncation 32)

;; Emoji
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)

;; Change Minibuffer Background
(add-hook 'minibuffer-setup-hook (lambda ()
                                   (set (make-local-variable 'face-remapping-alist)
                                        '((default :background "#1f1f1f")))))
;; Scrollbars only on active windows
(defun update-scroll-bars ()
  (interactive)
  (mapc (lambda (win)
          (set-window-scroll-bars win nil))
        (window-list))
  (set-window-scroll-bars (selected-window) 10 'right))


(add-hook 'window-configuration-change-hook 'update-scroll-bars)
(add-hook 'buffer-list-update-hook 'update-scroll-bars)

;; Theme



;; Mode Line Configuration
(require 'modeline)

;; Splash Screen
;; (use-package uptimes)
(use-package splash
  :load-path "modules/"
  :config
  (my-splash/show)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create "*splash*"))))

;; Fancy Ligatures
(use-package pragmatapro-lig
  :load-path "modules/"
  :when (display-graphic-p)
  :config
  (pragmatapro-lig-global-mode))


(provide 'appearance)
