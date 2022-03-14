;; -*- lexical-binding: t; -*-

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#1a1a1a" :foreground "#a9b7c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 130 :width normal))))
 '(fixed-pitch ((t (:family "IBM Plex Mono"))))
 '(flyspell-duplicate ((t nil)))
 '(fringe ((t (:background "#181818" :foreground "#fafafa"))))
 '(header-line ((t (:inherit mode-line :background "#181818" :foreground "#181818" :box (:line-width (100 . 2) :color "#181818")))))
 '(line-number ((t (:inherit default))))
 '(link ((t (:foreground "#7ca8c6" :underline t))))
 '(lsp-headerline-breadcrumb-path-face ((t nil)))
 '(lsp-headerline-breadcrumb-separator-face ((t (:inherit shadow))))
 '(lsp-headerline-breadcrumb-symbols-face ((t (:weight bold))))
 '(markdown-code-face ((t (:inherit fixed-pitch :foreground "#777"))))
 '(markdown-gfm-checkbox-face ((t (:inherit fixed-pitch :weight bold))))
 '(markdown-header-face ((t (:weight bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :underline "#555" :height 2.5))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-3 ((t (:inherit (variable-pitch markdown-header-face) :height 1.5))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :weight bold :height 1.0))))
 '(markdown-hr-face ((t (:foreground "#555"))))
 '(markdown-html-attr-name-face ((t (:inherit (font-lock-variable-name-face markdown-html-tag-name-face)))))
 '(markdown-html-attr-value-face ((t (:inherit (font-lock-string-face markdown-html-tag-name-face)))))
 '(markdown-html-tag-delimiter-face ((t (:inherit (markdown-markup-face markdown-html-tag-name-face)))))
 '(markdown-html-tag-name-face ((t (:inherit font-lock-type-face))))
 '(mode-line ((t (:background "#1a1a1a" :foreground "#777" :underline "#3a3a3a" :weight normal :family "IBM Plex Sans"))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#1a1a1a" :foreground "#777" :underline "#3a3a3a" :weight normal))))
 '(org-block ((t (:inherit fixed-pitch :extend t))))
 '(org-document-info ((t nil)))
 '(org-document-info-keyword ((t (:inherit org-meta-line))))
 '(org-document-title ((t (:inherit org-level-1 :underline "#555"))))
 '(org-done ((t (:foreground "#5e8759" :weight bold))))
 '(org-footnote ((t (:inherit org-link))))
 '(org-headline-done ((t nil)))
 '(org-level-1 ((t (:inherit markdown-header-face-1))))
 '(org-level-2 ((t (:inherit markdown-header-face-2))))
 '(org-level-3 ((t (:inherit markdown-header-face-3 :extend nil))))
 '(org-level-4 ((t (:inherit markdown-header-face-4 :extend nil))))
 '(org-level-5 ((t (:inherit markdown-header-face-5))))
 '(org-level-6 ((t (:inherit markdown-header-face-6))))
 '(org-link ((t (:foreground "#888" :underline t))))
 '(org-meta-line ((t (:inherit (fixed-pitch font-lock-comment-face) :foreground "#888"))))
 '(org-special-keyword ((t (:inherit nil :foreground "#888"))))
 '(org-superstar-item ((t (:inherit default :foreground "#555"))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-target ((t (:foreground "#888"))))
 '(org-todo ((t (:foreground "skyblue" :weight bold))))
 '(shadow ((t (:foreground "#666"))))
 '(variable-pitch ((t (:foreground "#d0d0d0" :height 1.1 :family "IBM Plex Sans"))))
 '(window-divider ((t (:foreground "#3a3a3a"))))
 '(window-divider-first-pixel ((t (:foreground "#1a1a1a"))))
 '(window-divider-last-pixel ((t (:foreground "#1a1a1a")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/local/libexec/emacs/29.0.50/x86_64-pc-linux-gnu" "/home/portal/.local/bin"))
 '(lsp-eldoc-enable-hover nil)
 '(lsp-headerline-breadcrumb-enable t)
 '(lsp-headerline-breadcrumb-enable-diagnostics nil)
 '(lsp-headerline-breadcrumb-icons-enable t)
 '(lsp-restart 'auto-restart)
 '(org-emphasis-alist
   '(("*" bold)
     ("/" italic)
     ("_" underline)
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim)
     ("+"
      (:strike-through t))))
 '(org-export-with-timestamps nil)
 '(org-format-latex-options
   '(:foreground "#d0d0d0" :background default :scale 1.3 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-latex-default-packages-alist
   '(("AUTO" "inputenc" nil
      ("pdflatex"))
     ("T1" "fontenc" t
      ("pdflatex"))
     ("" "graphicx" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("" "hyperref" nil nil)
     ("" "cancel" t nil)))
 '(org-latex-image-default-scale "1.3")
 '(org-modern-checkbox '((88 . "☒") (45 . "◫") (32 . "☐")))
 '(org-modern-list '((43 . "•") (45 . "•") (42 . "•")))
 '(org-modern-star ["#" "*" "" "" ""])
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
                  ("tectonic --outdir %o %f")
                  :image-converter
                  ("convert -density %D -trim -antialias %f -quality 100 %O"))))
 '(package-selected-packages
   '(org-fragtog gnuplot format-all format-all-the-code lsp-ui rust-mode vterm vertico use-package typescript-mode rainbow-mode parinfer-rust-mode origami org-superstar org-download no-littering neotree lua-mode lsp-mode kind-icon htmlize hotfuzz highlight-defined glsl-mode gdscript-mode flycheck evil eglot corfu consult company cape all-the-icons)))
'("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/local/libexec/emacs/29.0.50/x86_64-pc-linux-gnu" "/home/portal/.local/bin")
 '(org-indent-mode-turns-off-org-adapt-indentation nil)
 '(org-latex-default-packages-alist
   '(("AUTO" "inputenc" t
      ("pdflatex"))
     ("T1" "fontenc" t
      ("pdflatex"))
     ("" "graphicx" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("" "hyperref" nil nil)
     ("" "cancel" t nil)))
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
                   ("latex -interaction nonstopmode --outdir %o %f")
                   :image-converter
                   ("dvisvgm %f -n -b min -c %S -o %O"))
     (imagemagick :programs
                       ("tectonic" "convert")
                       :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                       (1.0 . 1.0)
                       :latex-compiler
                       ("tectonic --outdir %o %f")
                       :image-converter
                       ("convert -density %D -trim -antialias %f -quality 100 %O"))))
 '(org-src-tab-acts-natively t nil nil "Customized with use-package org")
 '(package-selected-packages
   '(glsl-mode gdscript-mode cape vterm vertico use-package typescript-mode rainbow-mode parinfer-rust-mode origami org-superstar org-download no-littering neotree lua-mode lsp-mode kind-icon htmlize hotfuzz highlight-defined flycheck evil eglot corfu consult company all-the-icons))
