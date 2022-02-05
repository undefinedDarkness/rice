;; -*- lexical-binding: t; -*-

;; Show separators between windows
(window-divider-mode 1)

;; Emoji
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)

;; Change Minibuffer Background & Hide Scrollbars
(add-hook 'minibuffer-setup-hook (lambda ()
                                   (set (make-local-variable 'face-remapping-alist)
                                        '((default :background "#1f1f1f"))))
                                 (set-window-scroll-bars (minibuffer-window) 0 'none))

;; Scrollbars only on active windows
(defun update-scroll-bars ()
  (unless (one-window-p)
    (interactive)
    (mapc (lambda (win)
            (set-window-scroll-bars win nil))
          (window-list))
    (set-window-scroll-bars (selected-window) 10 'right)
    (set-window-scroll-bars (minibuffer-window) 0 'none)))

(add-hook 'window-configuration-change-hook 'update-scroll-bars)
(add-hook 'buffer-list-update-hook 'update-scroll-bars)

;; Splash Screen
(use-package splash
  :load-path "modules/"
  :config
  (my-splash/show)
  :custom
  (initial-buffer-choice (lambda () (get-buffer-create "*splash*"))))

;; Color Theme
(add-to-list 'custom-theme-load-path (expand-file-name "modules/extern" user-emacs-directory))
(load-theme 'jetbrains-darcula t)

;; Apply a sans-serif font to certain buffers
(defun my/sans-serif-font () (variable-pitch-mode 1))
(add-hook 'help-mode-hook 'my/sans-serif-font)
(add-hook 'man-mode-hook 'my/sans-serif-font)

(provide 'appearance)
