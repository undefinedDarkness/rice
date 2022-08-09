;; -*- lexical-binding: t; -*-

;; Disable some modes
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Append to load path
(add-to-list 'load-path (expand-file-name "modules/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/extern" user-emacs-directory))

;; Init Package System
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Appearance

(pixel-scroll-precision-mode 1) ;; Good Scrolling
(fringe-mode -1)

;; Font
;; (add-to-list 'default-frame-alist '(font . "IBM Plex Mono Medium-12"))

;; Window Size
(add-to-list 'default-frame-alist '(width . 40))
(add-to-list 'default-frame-alist '(height . 18))

;; Window Padding
(add-to-list 'default-frame-alist '(internal-border-width . 24))

;; Hide Line Truncation Symbol
(set-display-table-slot standard-display-table 'truncation 32)

;; Performance
(defvar custom-file-name-handler-alist file-name-handler-alist)



(setq use-package-always-ensure t
      ;; Breaks config so not using it rn use-package-always-defer t 
      file-name-handler-alist nil
      
      ;; Package Starting Unwanted
      package-enable-at-startup nil
      package--init-file-ensured t
      package-native-compile t

      ;; Garbage Collector Hack
      gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6

      ;; Set Initial Major Mode To Fundamental
      initial-major-mode 'fundamental-mode
      frame-inhibit-implied-resize t)

;; Restore GC & File List To Normal
(add-hook 'emacs-startup-hook (lambda ()
                                (setq gc-cons-threshold 16777216 ; 16mb
                                      gc-cons-percentage 0.1
                                      file-name-handler-alist custom-file-name-handler-alist)))


(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
