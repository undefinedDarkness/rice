;; -*- lexical-binding: t; -*-

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "PragmataPro Liga"))))
 '(fringe ((t (:background "#181818" :foreground "#fafafa"))))
 '(header-line ((t (:inherit mode-line :background "#181818" :foreground "#181818" :box (:line-width (100 . 2) :color "#181818")))))
 '(link ((t (:foreground "#7ca8c6" :underline t))))
 '(markdown-code-face ((t (:inherit fixed-pitch :foreground "#777"))))
 '(markdown-gfm-checkbox-face ((t (:inherit fixed-pitch :weight bold))))
 '(markdown-header-face ((t (:weight heavy :family "Fraunces"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :underline "#555" :height 2.5))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-3 ((t (:inherit (variable-pitch markdown-header-face) :height 1.5))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-hr-face ((t (:foreground "#555"))))
 '(mode-line ((t (:background "#181818" :foreground "#181818" :underline "#555" :weight normal))))
 '(mode-line-inactive ((t (:inherit mode-line))))
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
 '(org-superstar-item ((t (:inherit default :foreground "#555"))))
 '(org-todo ((t (:foreground "skyblue" :weight bold))))
 '(variable-pitch ((t (:foreground "#d0d0d0" :height 150 :family "Commissioner")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bookmark-default-file "/home/portal/rice/.config/emacs/var/bookmark-default.el")
 '(bookmark-save-flag nil)
 '(custom-safe-themes nil)
 '(org-confirm-babel-evaluate nil)
 '(org-edit-src-content-indentation 2)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.2 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
				 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-preview-latex-default-process 'imagemagick)
 '(org-preview-latex-process-alist
   '((dvipng :programs
			 ("latex" "dvipng")
			 :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
			 (1.0 . 1.0)
			 :latex-compiler
			 ("latex -interaction nonstopmode -output-directory %o %f")
			 :image-converter
			 ("dvipng -D %D -T tight -bg Transparent -o %O %f"))
	 (dvisvgm :programs
			  ("latex" "dvisvgm")
			  :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
			  (1.7 . 1.5)
			  :latex-compiler
			  ("latex -interaction nonstopmode -output-directory %o %f")
			  :image-converter
			  ("dvisvgm %f -n -b min -c %S -o %O"))
	 (imagemagick :programs
				  ("tectonic" "convert")
				  :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :image-input-type "pdf" :image-output-type "png" :image-size-adjust
				  (1.0 . 1.0)
				  :latex-compiler
				  ("tectonic -o %o %f")
				  :image-converter
				  ("convert -density %D -trim -antialias %f -quality 100 %O"))))
 '(org-src-preserve-indentation t)
 '(org-superstar-item-bullet-alit '((42 . 8226) (43 . 8226) (45 . 8226)))
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(flycheck typescript-mode origami hotfuzz flx vterm vertico use-package uptimes rainbow-mode projectile perfect-margin parinfer-rust-mode org-superstar org-download org-bullets no-littering neotree markdown-mode magit lua-mode htmlize highlight-defined evil consult centered-window all-the-icons)))
 ;; '(package-selected-packages
   ;; '(highlight-defined org-download htmlize org-superstar org-bullets projectile vterm vertico use-package rainbow-mode perfect-margin parinfer-rust-mode neotree markdown-mode magit lua-mode evil consult centered-window all-the-icons))
