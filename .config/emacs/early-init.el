;; Use Native Comp
(setq comp-deferred-compilation t
      comp-speed 3
      comp-async-report-warnings-errors nil)


;; Opimizaitions: Taken from f2k config
(setq-default file-name-handler-alist nil
              create-lockfiles nil
              bidi-display-reordering nil
              cursor-in-non-selected-windows nil
              highlight-nonselected-windows nil
              frame-inhibit-implied-resize t
              inhibit-compacting-font-caches nil
              read-process-output-max (* 1024 1024))


;; Garbage Colletor
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; Window Decorations
(scroll-bar-mode -1); Disable visible scrollbar
(tool-bar-mode -1)  ; Disable the toolbar
(tooltip-mode -1)   ; Disable tooltips
(set-fringe-mode 0); Give some breathing room
(menu-bar-mode -1)  ; Disable the menu bar

;; Settings
(setq-default inhibit-startup-screen nil ; Disable default startup screen
              make-backup-files nil ; No Backup File
              truncate-lines t ; Dont Wrap Lines
              frame-title-format '("Editing: %f") ; Window Title
              mode-line-format'("") ; Nothing to see here
              indent-tabs-mode nil) ; Tabs are evil

;; Use Package.el
(require 'package)

(setq package-enable-at-startup nil
      package-native-compile t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
