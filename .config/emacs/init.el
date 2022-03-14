;; -*- lexical-binding: t; -*-
(package-initialize)
(require 'use-package)

;; Clean up emacs configuration directory
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

;; Settings for builtins that I have not made a new place for
(use-package emacs
  :custom
  (auto-save-default nil)
  (comp-deferred-compilation t)
  (backup-inhibited t)
  (confirm-kill-processes nil)
  (bookmark-save-flag t)
  (image-use-external-converter t)
  (tab-always-indent 'complete)
  (frame-title-format "Editing: %b")  
  (custom-file  (expand-file-name "modules/custom.el" user-emacs-directory))
  (bookmark-default-file (expand-file-name "var/bookmark-default.el" user-emacs-directory)))

(setq-default tab-width 4
              mode-line-format "⠀"
              indent-tabs-mode nil
              cursor-in-non-selected-windows nil)

(unless (or noninteractive (display-graphic-p))
 (require 'terminal)) 

(unless noninteractive
  ;; New UI Components
  ;; & Appearance Settings
  (require 'ui))

;; Editing Experience
(require 'programming)

;; Writing Experience
(require 'writing)

(load-file custom-file)
