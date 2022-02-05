;; -*- lexical-binding: t; -*-

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#1a1a1a" :foreground "#a9b7c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 130 :width normal :foundry "UKWN" :family "iA Writer Quattro V"))))
 '(fixed-pitch ((t nil)))
 '(fringe ((t (:background "#181818" :foreground "#fafafa"))))
 '(header-line ((t (:inherit mode-line :background "#181818" :foreground "#181818" :box (:line-width (100 . 2) :color "#181818")))))
 '(link ((t (:foreground "#7ca8c6" :underline t))))
 '(markdown-code-face ((t (:inherit fixed-pitch :foreground "#777"))))
 '(markdown-gfm-checkbox-face ((t (:inherit fixed-pitch :weight bold))))
 '(markdown-header-face ((t (:weight bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :underline "#555" :height 2.5))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-3 ((t (:inherit (variable-pitch markdown-header-face) :height 1.5))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-hr-face ((t (:foreground "#555"))))
 '(mode-line ((t (:background "#1a1a1a" :foreground "#777" :underline "#3a3a3a" :weight normal :family "IBM Plex Sans"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#1a1a1a" :foreground "#777" :underline "#3a3a3a" :weight normal))))
 '(org-block ((t (:inherit fixed-pitch :extend t))))
 '(org-document-info ((t nil)))
 '(org-document-info-keyword ((t (:inherit org-meta-line))))
 '(org-document-title ((t (:inherit org-level-1 :underline "#555"))))
 '(org-done ((t (:foreground "#5e8759" :weight bold))))
 '(org-headline-done ((t nil)))
 '(org-level-1 ((t (:inherit markdown-header-face-1))))
 '(org-level-2 ((t (:inherit markdown-header-face-2))))
 '(org-level-3 ((t (:inherit markdown-header-face-3))))
 '(org-level-4 ((t (:extend nil))))
 '(org-level-5 ((t (:inherit markdown-header-face-5))))
 '(org-level-6 ((t (:inherit markdown-header-face-6))))
 '(org-meta-line ((t (:inherit (fixed-pitch font-lock-comment-face) :foreground "#888"))))
 '(org-superstar-item ((t (:inherit default :foreground "#555"))))
 '(org-todo ((t (:foreground "skyblue" :weight bold))))
 '(shadow ((t (:foreground "#666"))))
 '(variable-pitch ((t (:foreground "#d0d0d0" :height 1.1 :family "IBM Plex Sans"))))
 '(window-divider ((t (:foreground "#3a3a3a"))))
 '(window-divider-first-pixel ((t (:foreground "#1a1a1a")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cape vterm vertico use-package typescript-mode rainbow-mode parinfer-rust-mode origami org-superstar org-download no-littering neotree lua-mode lsp-mode kind-icon htmlize hotfuzz highlight-defined flycheck evil eglot corfu consult company all-the-icons)))
