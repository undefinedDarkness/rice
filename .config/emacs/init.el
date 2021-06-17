;; Dont clutter my ~/.config/emacs
(use-package no-littering)

;;(hl-line-mode -1)
;;(global-hl-line-mode -1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode) ; Show Line Numbers
(set-display-table-slot standard-display-table 0 ?\ ) ; Remove $ at end of long lines

;; Color Emoji󠁴
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)


;; Settings
(setq-default inhibit-startup-screen nil ; Disable default startup screen
              make-backup-files nil ; No Backup File
              truncate-lines t ; Dont Wrap Lines
              frame-title-format '("Editing: %f") ; Window Title
              mode-line-format'("") ; Nothing to see here
              completion-show-help nil ; Dont need help
              indent-tabs-mode nil ; Dont Indent With Tabs
              js-indent-level 2 ; Indents for javascript
              tab-width 4) ; 4 Tabs

(setq indent-line-function 'insert-tab)

;; Disable Backups & Autosaves -- CHANGE
(setq backup-inhibited t
      auto-save-default nil)

;; Splash Screen
(load-file (expand-file-name "./lisp/splash.el" user-emacs-directory))
(show-splash)
(setq initial-buffer-choice (lambda () (get-buffer-create "*splash*")))

;; Change Startup Message -- CHANGE
(defun display-startup-echo-area-message ()
  "My custom startup message."
  (message "🍱 Dont forget to have fun"))

;; Fonts & Ligatures -- CHANGE
(set-frame-font "Sarasa Term K 12")

;; Options
(set-frame-parameter nil 'internal-border-width 16) ; Padding
(use-package ligature
  ;;:disabled
  :load-path "./lisp"
  :defer t
  :hook (prettify-symbols-mode . ligature-mode)
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://")))

;; Evil Mode
(use-package evil
  :custom
  (evil-default-state 'normal)
  (evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :defer t
  :hook (vterm-mode . (lambda () (evil-collection-init 'vterm))))

;; Colorscheme
;;(setq custom-theme-directory "~/.config/emacs/lisp")
;;(load-theme 'an-old-hope t)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))

;; LSP & Company Mode
(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :hook ((css-mode . lsp) ; CSS 
         (c-mode . lsp)     ; CLANGD
         (rust-mode . lsp)  ; RUST-ANALYZER
         (zig-mode . lsp))  ; ZIG-LS
  :config
  (setq lsp-headerline-breadcrumb-enable nil))

(use-package company
  :defer t
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
 

;; Fly Check - Might go for flymake instead not sure atm
(use-package flycheck
  :defer t
  :hook ((prog-mode . flycheck-mode)
         (emacs-lisp-mode . (lambda () (flycheck-mode -1)))))
 

;; Treemacs (Directory Browser)
(use-package treemacs
  :defer t
  :commands treemacs
  :custom
  (treemacs-follow-mode nil)
  (treemacs-fringe-indicator-mode nil)
  (treemacs-width 25)
  :config
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(use-package treemacs-evil
  :defer t
  :after (treemacs evil))

;; Emacs Lisp

(use-package highlight-defined ; Make Elisp Highlighting Not Shit
  :defer t
  :hook (emacs-lisp-mode . highlight-defined-mode))

(use-package parinfer-rust-mode ; Le epic parinfer
  :defer t
  :hook (emacs-lisp-mode . parinfer-rust-mode))

;; Language Modes
(use-package lua-mode
  :defer t
  :mode "\\.lua\\'"
  :custom
  (lua-indent-level 4)
  (lua-indent-string-contents t))

(use-package rust-mode
  :defer t
  :mode "\\.rs\\'")

(use-package zig-mode
  :defer t
  :mode "\\.zig\\'")

;; Org Mode
(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . flyspell-mode)
         (org-mode . (lambda () ; Use A Serif Font In Org Mode
                       (setq buffer-face-mode-face '(:family "Merriweather")
                             left-margin-width 4
                             right-margin-width 4)
                       (buffer-face-mode))))
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-display-remote-inline-images 'cache)
  (org-fontify-done-headline t)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-highlight-latex-and-related '(native latex script entities))
  (org-pretty-entities t)
  (org-startup-with-inline-images t)) 
 
;;  Markdown Mode
(use-package markdown-mode
  :defer t
  :mode ("\\.md\\'" . markdown-mode)
  :custom
   (markdown-code-lang-modes)
   (markdown-display-remote-images t)
   (markdown-enable-math t)
   (markdown-hide-markup t)
   (markdown-indent-on-enter 'indent-and-new-item)
  :hook (markdown-mode . (lambda ()
                           (flyspell-mode t)
                           (markdown-toggle-inline-images) ; Display images immediatly because not doing that is dumb
                           (setq buffer-face-mode-face '(:family "Merriweather")
                                 left-margin-width 4
                                 right-margin-width 4)
                           (buffer-face-mode))))

;; Terminal
(use-package vterm
  :defer t
  :commands vterm
  :custom
  (vterm-copy-exclude-prompt t)
  (vterm-use-vterm-prompt-detection-method t)
  (vterm-shell "/bin/bash") ;; -- CHANGE
  (vterm-always-compile-module t)
  (vterm-kill-buffer-on-exit t))

;; Indentation & Code Folding

(use-package folding
  :defer t
  :hook (prog-mode . folding-mode))

;; Colors
(use-package rainbow-mode
  :defer t
  :hook (lua-mode . rainbow-mode))

;; Load Customizations
(setq custom-file (concat user-emacs-directory "lisp/customizations.el"))
(load custom-file)
