;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f2d60bed3ad4358c7822124f2baa9e29756dca976ae75c1f7abe7603b7c1c74e" "9f431ef8045d306c317eb50bf9cb3f203e05bca62d2c679d43d383f096209dca" "83a945ee4c01c0bf928d1c908a4fc19669b29d47873aa967b5190a2e7a43f59f" "429bdaf3b84711609077be0f3a451475fb209f46fb2f8165e86beaf2ee0fa674" "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5" "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "184b3a18e5d1ef9c8885ceb9402c3f67d656616d76bf91f709d1676407c7cf1d" default))
 '(exec-path
   '("/usr/local/bin" "/usr/bin" "/bin" "/usr/local/games" "/usr/games" "/usr/local/libexec/emacs/29.0.50/x86_64-pc-linux-gnu" "/home/portal/.local/bin"))
 '(markdown-hide-markup nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.3 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["
                  '(org-latex-default-packages-alist
                    '(("AUTO" "inputenc" nil)
                      ("pdflatex")
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
                      ("" "cancel" t nil
                       '(org-latex-image-default-scale "1.3"
                                                       '(org-preview-latex-default-process 'imagemagick)))))
                  '(org-preview-latex-process-alist
                    '((dvipng :programs)
                      ("latex" "dvipng")
                      :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
                      (1.0 . 1.0)
                      :latex-compiler
                      ("latex -interaction nonstopmode -output-directory %o %f")
                      :image-converter
                      ("dvipng -D %D -T tight -bg Transparent -o %O %f")
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
                    '(tao-theme org-fragtog gnuplot format-all format-all-the-code lsp-ui rust-mode vterm vertico use-package typescript-mode rainbow-mode parinfer-rust-mode origami org-superstar org-download no-littering neotree lua-mode lsp-mode kind-icon htmlize hotfuzz highlight-defined glsl-mode gdscript-mode flycheck evil eglot corfu consult company cape all-the-icons))
                  '(tao-theme-sepia-depth 10))))
 '(org-latex-pdf-process '("tectonic -o %o %f"))
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
 '(package-selected-packages
   '(emmet-mode skewer-mode yaml-mode hl-todo vterm vertico use-package typescript-mode tao-theme rust-mode rainbow-mode parinfer-rust-mode origami org-superstar org-fragtog org-download no-littering neotree lua-mode lsp-ui kind-icon htmlize hotfuzz highlight-defined gnuplot glsl-mode github-modern-theme gdscript-mode format-all flycheck evil eglot corfu consult company cape all-the-icons)))
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight medium :height 140 :width normal :foundry "IBM " :family "IBM Plex Mono"))))
 '(fixed-pitch ((t (:family "JuliaMono"))))
 '(hl-todo ((t (:weight bold))))
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight semi-bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :weight bold :height 1.1))))
 '(mode-line ((t (:foreground "#bcbdc0" :underline (:color foreground-color :style line :position t)))))
 '(org-block ((t (:inherit (fixed-pitch shadow) :extend t))))
 '(org-done ((t (:weight bold))))
 '(org-headline-done ((t nil)))
 '(org-level-1 ((t (:inherit markdown-header-face-1))))
 '(org-level-2 ((t (:inherit markdown-header-face-2 :extend t))))
 '(org-level-3 ((t (:inherit markdown-header-face-3 :extend nil))))
 '(org-level-4 ((t (:inherit markdown-header-face-4 :extend nil))))
 '(org-level-5 ((t (:extend nil))))
 '(org-modern-done ((t (:inherit org-modern-label :background "gray90" :foreground "black" :weight bold))))
 '(org-modern-horizontal-rule ((t nil)))
 '(org-modern-todo ((t (:inherit (org-todo org-modern-label) :weight bold :inverse-video t))))
 '(outline-2 ((t nil)))
 '(variable-pitch ((t (:family "IBM Plex Sans"))))
 '(window-divider-first-pixel ((t (:inherit default :inverse-video t))))
 '(window-divider-last-pixel ((t (:inherit default :inverse-video t)))))
