;; -*- lexical-binding: t; -*-

;; Disable
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Append to load path
(add-to-list 'load-path (expand-file-name "modules/" user-emacs-directory))

;; Init Package System
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defvar custom-file-name-handler-alist file-name-handler-alist)
(setq use-package-always-ensure t
      file-name-handler-alist nil
 
      ;; Package Starting Unwanted
      package-enable-at-startup nil
      package--init-file-ensured t

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
     

