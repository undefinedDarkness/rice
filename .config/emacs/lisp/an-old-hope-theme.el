;; an-old-hope-theme.el -- a syntax theme from a galaxy far away... -*- lexical-binding: t -*-
;; Author: MoHKale
;; URL: https://github.com/MoHKale/an-old-hope-theme
;; Version: 0.1.0
;; Keywords: color, theme
;; Package-Requires: ((emacs "24"))

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;; Commentary:
;; see https://github.com/MoHKale/an-old-hope-theme/tree/master/emacs

(deftheme an-old-hope
  "emacs theme inspired by a galaxy far far away...
this theme is largely just a shot for shot copy of `jesseleite/an-old-hope-syntax-atom'
ported to emacs because I refuse to live with an IDE that doesn't look like it XD.
This theme isn't compatible with emacs in the terminal yet, when I find an easy way
to approximate true-color colors to non-true-color colors, then I'll add support for
it.
")

(with-eval-after-load 'ivy
  (defface ivy-actual-highlight-face '((t (:inherit highlight)))
    "face actually used by ivy to highlight some candidates.
see an-old-hope-theme.el for why this is necessary."))

(custom-theme-set-faces 'an-old-hope
 ;; defaults
 '(default ((t (:background "#1c1d20" :foreground "#cbccd1"))))
 '(italic ((t (:italic t :inherit default))))
 '(underline ((t (:inherit default))))
 '(shadow ((t (:foreground "#848794"))))
 '(hl-line ((t (:background "#313339"))))

 '(font-lock-builtin-face ((t (:foreground "#4fb3d8"))))
 '(font-lock-comment-face ((t (:foreground "#686b78"))))
 '(font-lock-keyword-face ((t (:foreground "#78bd65"))))
 '(font-lock-constant-face ((t (:foreground "#ea3d54" :inherit bold))))
 '(font-lock-function-name-face ((t (:foreground "#fedd38"))))
 '(font-lock-negation-char-face ((t (:foreground "#ea3d54"))))
 '(font-lock-preprocessor-face ((t (:foreground "#86b270"))))
 '(font-lock-string-face ((t (:foreground "#4fb3d8"))))
 '(font-lock-doc-face ((t (:foreground "#4fb3d8")))) ; TODO optional bg
 '(font-lock-type-face ((t (:foreground "#ea3d54"))))
 '(font-lock-variable-name-face ((t (:foreground "#fedd38"))))
 '(font-lock-warning-face ((t (:background "#fedd38" :distant-foreground "#fedd38" :foreground "#1c1d20" :underline nil :inherit bold))))

 '(error ((t (:background "#ea3d54" :distant-foreground "#ea3d54" :foreground "#1c1d20" :inherit bold))))
 '(success ((t (:background "#78bd65" :distant-foreground "#78bd65" :foreground "#1c1d20" :inherit bold))))
 '(warning ((t (:background "#e5cc51" :distant-foreground "#e5cc51" :foreground "#1c1d20" :inherit bold))))

 '(cursor ((t (:background "#ea3d54"))))
 '(custom-button ((t (:background "#1c1d20" :foreground "#cbccd1" :box (:line-width 2 :style released-button)))))

 '(fringe ((t (:background "#212125"))))
 '(header-line ((t (:background "#1c1d20" :foreground "#4fb3d8"))))
 '(line-number ((t (:background "#212125" :foreground "#cbccd1"))))
 '(line-number-current-line ((t (:foreground "#4fb3d8" :inherit line-number))))
 '(vertical-border ((t (:foreground "#cbccd1"))))
 '(internal-border ((t (:foreground "#ffffff" :background "#ffffff"))))
 '(minibuffer-prompt ((t (:foreground "#e5cc51" :weight bold))))

 '(highlight ((t (:foreground "#1c1d20" :background "#4fb3d8" :distant-foreground "#4fb3d8" :inherit bold))))

 '(region ((t (:background "#44464f" :weight bold))))
 '(secondary-selection ((t (:inherit region))))

 ;; face for current search match. exiting now takes you to it.
 '(isearch ((t (:background "#b978ab" :inherit bold))))
 '(isearch-fail ((t (:inherit compilation-mode-line-fail))))
 '(match ((t (:foreground "#86b270"))))
 ;; face for matches other than the current match
 '(lazy-highlight ((t (:background "#5689f0" :foreground "#2d2d38"))))

 ;; delimeter colors just taken from https://github.com/gastrodia/rainbow-brackets
 ;; colors 5-8 just recycle 1-4, maybe come up with more.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#E6B422"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#C70067"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#00A960"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#FC7482"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#E6B422"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#C70067"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#00A960"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#FC7482"))))

 ;; hyperlinks and path links
 '(link ((t (:foreground "#4fb3d8"))))
 '(link-visited ((t (:foreground "#67e4c4"))))

 ;;; modeline/spaceline
 '(mode-line ((t (:background "#cbccd1" :foreground "#1c1d20" :box (:line-width 1 :color "#cbccd1" :style none)))))

 '(spaceline-evil-normal ((t (:inherit mode-line :foreground "#1c1d20" :background "DarkGoldenrod2"))))
 '(spaceline-evil-insert ((t (:inherit mode-line :foreground "#1c1d20" :background "#5ac85a"))))
 '(spaceline-evil-emacs ((t (:inherit mode-line :foreground "#1c1d20" :background "#4fb3d8"))))
 '(spaceline-evil-replace ((t (:inherit mode-line :foreground "#1c1d20" :background "#19e5b2"))))
 '(spaceline-evil-visual ((t (:inherit mode-line :foreground "#cbccd1" :background "#44464f"))))
 '(spaceline-evil-motion ((t (:inherit mode-line :foreground "#1c1d20" :background "#c170b0"))))
 '(spaceline-minibuffer ((t (:inherit mode-line :foreground "#1c1d20" :background "#4fb3d8"))))

 '(spaceline-flycheck-error ((t (:inherit bold :foreground "#d45364"))))
 '(spaceline-flycheck-warning ((t (:inherit bold :foreground "#d68e5b"))))
 '(spaceline-flycheck-info ((t (:inherit bold :foreground "#86b270"))))

 ;; major mode indicator
 '(powerline-active1 ((t (:background "#212125" :foreground "#cbccd1" :inherit mode-line))))
 ;; file-format + cursor-pos
 '(powerline-active2 ((t (:background "#212125" :foreground "#cbccd1" :inherit mode-line))))

 ;;; evil
 '(vimish-fold-overlay ((t (:background "#44464f" :foreground "#78bd65"))))

 ;;; flycheck
 '(flycheck-info ((t (:underline (:style wave :color "#78bd65")))))
 '(flycheck-warning ((t (:underline (:style wave :color "#e5cc51")))))
 '(flycheck-duplicate ((t (:underline (:style wave :color "#ee7b29")))))
 '(flycheck-incorrect ((t (:underline (:style wave :color "#ea3d54")))))

 '(flycheck-fringe-info ((t (:foreground "#5ac85a" :inherit fringe))))
 '(flycheck-fringe-warning ((t (:foreground "#fedd38" :inherit fringe))))
 '(flycheck-fringe-error ((t (:foreground "#f43333" :inherit fringe))))

 ;;; flyspell
 '(flyspell-duplicate ((t (:foreground "#d68e5b" :underline t))))
 '(flyspell-incorrect ((t (:foreground "#d45364" :underline t))))

 ;;; avy
 '(avy-background-face ((t (:foreground "#686b78"))))
 '(avy-lead-face ((t (:background "#f43333" :foreground "#ffffff"))))
 '(avy-lead-face-0 ((t (:background "#5689f0" :foreground "#ffffff"))))
 '(avy-lead-face-1 ((t (:background "#cbccd1" :foreground "#1c1d20"))))
 '(avy-lead-face-2 ((t (:background "#c170b0" :foreground "#ffffff"))))

 '(frog-menu-border ((t (:background "#ffffff" :foreground "#ffffff"))))
 '(frog-menu-posframe-background-face ((t (:background "#1c1d20"))))

 ;;; company - intellisense
 '(company-tooltip-mouse ((t (:foreground "#19e5b2"))))
 '(company-template-field ((t (:foreground "#19e5b2"))))

 ;; scrollbar
 '(company-scrollbar-bg ((t (:background "#cbccd1" :foreground "#cbccd1"))))
 '(company-scrollbar-fg ((t (:background "#44464f" :foreground "#44464f"))))

 '(company-preview ((t (:foreground "#5689f0" :weight bold :inherit hl-line))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-preview-search ((t (:foreground "#f29858" :weight normal :inherit company-preview))))

 ;; NOTE tooltip is the drop down menu which shows up when multiple results exist
 '(company-tooltip ((t (:inherit bold :background "#cbccd1" :foreground "#1c1d20"))))
 '(company-tooltip-selection ((t (:foreground "#cbccd1" :background "#5689f0"))))
 '(company-tooltip-common ((t (:foreground "#5689f0" :inherit company-tooltip))))
 '(company-tooltip-common-selection ((t (:foreground "#1c1d20" :background "#5689f0" :inherit company-tooltip-common))))
 '(company-tooltip-search ((t (:foreground "#ee7b29" :inherit company-tooltip))))
 '(company-tooltip-search-common ((t (:inherit company-tooltip-search))))
 '(company-tooltip-search-selection ((t (:background "#5689f0" :inherit company-tooltip-search))))

 ;; NOTE annotations are extra information in the tooltip
 '(company-tooltip-annotation ((t (:weight bold :foreground "#686b78"))))
 '(company-tooltip-annotation-selection ((t (:foreground "#19e5b2" :background "#5689f0" :inherit company-tooltip-annotation))))

 ;;;; custom mode variants
 ;;; whitespace-mode
 ;; `(whitespace-trailing ((,cls (:foreground "yellow" :background ,red))))
 '(whitespace-space ((t (:foreground "#44464f"))))
 '(trailing-whitespace ((t (:background "#44464f"))))

 ;;; auto-highlight-symbol mode
 ;; Note: distant foreground is meaningless here because the faces are always given priority
 '(ahs-definition-face ((t (:background "#64a3c3" :distant-foreground "#64a3c3" :foreground "#44464f"))))
 '(ahs-edit-mode-face ((t (:background "#d45364" :distant-foreground "#d45364" :foreground "#cbccd1"))))
 '(ahs-face ((t (:background "#cbccd1" :foreground "#212125" :inherit bold))))
 '(ahs-plugin-whole-buffer-face ((t (:background "#4fb3d8" :distant-foreground "#78bd65" :foreground "#212125"))))
 '(ahs-plugin-bod-face ((t (:background "#5689f0" :distant-foreground "#5689f0" :foreground "#212125"))))
 '(ahs-plugin-defalt-face ((t (:background "#d68e5b" :distant-foreground "#d68e5b" :foreground "#212125"))))
 '(ahs-warning-face ((t (:foreground "#d45364"))))

 ;;; compilation mode
 '(compilation-line-number ((t (:foreground "#e5cc51"))))
 '(compilation-column-number ((t (:inherit font-lock-doc-face))))

 ;; NOTE also represents value count in mode line
 '(compilation-error ((t (:foreground "#f43333" :inherit bold))))
 '(compilation-info ((t (:foreground "#5ac85a" :inherit bold))))
 '(compilation-warning ((t (:foreground "#f29858" :inherit bold))))

 ;; NOTE these only represent the exit status indicator
 ;; `(compilation-mode-line-exit ((,cls (:foreground very-dark-grey))))
 ;; `(compilation-mode-line-fail ((,cls (:foreground ,very-dark-grey))))
 ;; `(compilation-mode-line-run ((,cls (:foreground ,very-dark-grey))))

 ;;; markdown-mode
 '(markdown-code-face ((t (:inherit default))))

 ;;; anzu
 '(anzu-mode-line ((t (:foreground "#1c1d20" :inherit bold))))
 '(anzu-mode-line-no-match ((t (:foreground "#f43333" :inherit bold))))

 ;;; hydra-posframe
 ;; for some reason... if hydra-posframe-face inherits default, internal border won't work
 '(hydra-posframe-face ((t (:background "#1c1d20" :foreground "#cbccd1"))))
 '(hydra-posframe-border-face ((t (:inherit internal-border))))

 ;;; ivy
 ;; by default, it seems if ivy-highlight-face has its own spec, it'll interfere
 ;; with the face of ivy-current-match. Which'll make it harder to tell which
 ;; candidate is the current candidate.
 ;;
 ;; If ivy-highlight-face just inherits another face, then when both it and
 ;; ivy-current-match are applied to a string, ivy-current-match will override
 ;; ivy-highlight-face. Thus, this.
 '(ivy-actual-highlight-face ((t (:foreground "#1c1d20" :background "#67e4c4" :distant-foreground "#67e4c4" :inherit bold))))
 '(ivy-highlight-face ((t (:inherit ivy-actual-highlight-face))))

;;; org-mode
 '(org-link ((t (:foreground "#4fb3d8" :inherit bold))))
 '(org-footnote ((t (:foreground "#4fb3d8"))))

 ;; Overridden by hl-todo-keyword-faces
 '(org-todo ((t (:foreground "#c170b0" :inherit bold))))
 '(org-done ((t (:foreground "#5ac85a" :inherit bold))))

 '(org-upcoming-deadline ((t (:foreground "#d45364"))))
 '(org-warning ((t (:foreground "#ee7b29" :inherit bold))))
 '(org-scheduled-today ((t (:foreground "#5ac85a"))))
 '(org-block-begin-line ((t (:background "royalblue4" :distant-foreground "royalblue4" :foreground "steelblue1" :extend t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face)))))

 '(org-block ((t (:background "#17181b" :extend t))))
 '(org-document-title ((t (:foreground "#ffffff" :height 1.3 :inherit bold))))

 ;;; rust[ic]-mode
 '(rustic-compilation-warning ((t (:inherit compilation-warning))))
 '(rustic-compilation-info ((t (:inherit compilation-info))))
 '(rustic-compilation-error ((t (:inherit compilation-error))))
 '(rustic-compilation-column ((t (:inherit compilation-column-number))))
 '(rustic-compilation-line ((t (:inherit compilation-line-number))))

 ;;; dashboard
 '(dashboard-text-banner ((t (:foreground "#f29858"))))

 ;;; eshell-prompt-extras
 '(epe-remote-face ((t (:foreground "#67e4c4"))))
 '(epe-venv-face ((t (:foreground "#b978ab"))))

 ;;; magit
 '(magit-mode-line-process-error ((t (:foreground "#ea3d54" :background "#cbccd1" :inherit bold))))

 ;;; typescript
 '(typescript-primitive-face ((t (:inherit font-lock-type-face))))

 ;;; latex
 '(font-latex-sedate-face ((t (:inherit font-lock-keyword-face))))
 '(font-latex-sectioning-0-face ((t (:inherit font-lock-function-name-face))))
 '(font-latex-sectioning-1-face ((t (:inherit font-lock-function-name-face))))
 '(font-latex-sectioning-2-face ((t (:inherit font-lock-function-name-face))))
 '(font-latex-sectioning-3-face ((t (:inherit font-lock-function-name-face))))
 '(font-latex-sectioning-4-face ((t (:inherit font-lock-function-name-face))))
 '(font-latex-sectioning-5-face ((t (:inherit font-lock-function-name-face))))

 ;;; man/woman
 '(Man-underline ((t (:foreground "#5ac85a" :inherit bold))))
 '(woman-addition ((t (:foreground "#b978ab"))))
 '(woman-bold ((t (:foreground "#ea3d54" :inherit bold))))
 '(woman-unknown ((t (:inherit error))))
 '(woman-italic ((t (:foreground "#78bd65"))))
 )

(custom-theme-set-variables 'an-old-hope
  '(hl-todo-keyword-faces
    '(("TODO"       . "#ea3d54")
      ("NEXT"       . "#ea3d54")
      ("RANT"       . "#ea3d54")
      ("SEE"        . "#ea3d54")
      ("THEM"       . "#b978ab")
      ("PROG"       . "#5689f0")
      ("OKAY"       . "#5689f0")
      ("DONT"       . "#5ac85a")
      ("FAIL"       . "#ea3d54")
      ("DONE"       . "#5ac85a")
      ("NOTE"       . "#fedd38")
      ("KLUDGE"     . "#fedd38")
      ("HACK"       . "#fedd38")
      ("TEMP"       . "#fedd38")
      ("FIXME"      . "#ee7b29")
      ("WARN"       . "#ee7b29")
      ("XXX+"       . "#ee7b29")
      ("\\?\\?\\?+" . "#ee7b29"))))

(provide-theme 'an-old-hope)
