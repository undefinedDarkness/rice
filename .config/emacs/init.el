;; -*- lexical-binding: t; -*-
(package-initialize)
(require 'use-package)

(use-package no-littering)
(use-package patch
  :load-path "modules")

;; VIM style editing
(use-package evil
  :after patch
  :unless noninteractive
  :config
  (evil-mode 1)
  (require 'bindings))

(setq auto-save-default nil
      backup-inhibited t
      tab-always-indent nil
      confirm-kill-processes nil
      bookmark-save-flag t
      frame-title-format "Editing: %b"  
      custom-file (expand-file-name "modules/custom.el" user-emacs-directory))

(setq-default tab-width 4)

(unless (display-graphic-p)
    (require 'tty))
(unless noninteractive
  (progn (require 'appearance)
         (require 'ui)
         (require 'programming)))

(require 'writing)
