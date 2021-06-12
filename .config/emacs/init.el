
;; Dont clutter my ~/.config/emacs
(use-package no-littering)
  
;; Options

; (add-hook 'prog-mode-hook 'display-line-numbers-mode) ; Show Line Numbers
(set-display-table-slot standard-display-table 0 ?\ ) ; Remove $ at end of long lines

;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)


;; Splash Screen
(load-file (expand-file-name "./lisp/splash.el" user-emacs-directory))
(show-splash)
(setq initial-buffer-choice (lambda () (get-buffer-create "*splash*")))

;; Change Startup Message
(defun display-startup-echo-area-message ()
  "My custom startup message."
  (message "🍱 Dont forget to have fun"))

;; Fonts & Ligatures
(set-frame-font "Sarasa Term K 12")

;; Options
(set-frame-parameter nil 'internal-border-width 16) ; Padding
(use-package ligature
  :disabled
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
(use-package gruvbox-theme
  :config
    (load-theme 'gruvbox-dark-medium t))

;; LSP & Company Mode
(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :hook ((c-mode . lsp)
         (rust-mode . lsp)) ; Clangd is epic
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
  :hook (prog-mode . flycheck-mode))

;; Treemacs (Directory Browser)

(use-package treemacs
  :defer t
  :commands treemacs
  :custom
  (treemacs-width 25))

(use-package treemacs-evil
  :defer t
  :after (treemacs evil))

;; Emacs Lisp

(use-package highlight-defined ; Make Highlighting Not Shit
  :defer t
  :hook (emacs-lisp-mode . highlight-defined-mode))

(use-package parinfer-rust-mode
  :defer t
  :hook (emacs-lisp-mode . parinfer-rust-mode))

;; Language Modes
(use-package lua-mode
  :defer t
  :mode "\\.lua\\'")

(use-package rust-mode
  :defer t
  :mode "\\.rs\\'")

;; Org Mode & Markdown
(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . flyspell-mode)
         (org-mode . (lambda () ; Use A Serif Font In Org Mode
                            (setq buffer-face-mode-face '(:family "Merriweather"))
                            (buffer-face-mode))))
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-todo-keywords '((sequence "TODO" "DONE"))))

(add-hook 'markdown-mode-hook (lambda ()
                                (setq buffer-face-mode-face '(:family "Merriweather"))
                                (buffer-face-mode)))

;; Terminal
(use-package vterm
  :defer t
  :commands vterm
  :custom
  (vterm-copy-exclude-prompt t)
  (vterm-use-vterm-prompt-detection-method t)
  (vterm-shell "/bin/bash")
  (vterm-always-compile-module t)
  (vterm-kill-buffer-on-exit t))

;; Load Customizations
(setq custom-file (concat user-emacs-directory "lisp/customizations.el"))
(load custom-file)
