;; -*- lexical-binding: t; -*-

;; =================
;; Org Mode & Plugins
;; =================

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-agenda-files '("~/Documents/todo.org"))
  (org-src-tab-acts-natively t)
  (org-src-preserve-indentation t)
  (org-adapt-indentation 'headline-data)
  (org-confirm-babel-evaluate nil)
  (org-edit-src-content-indentation 2)

  (org-todo-keywords '((sequence "TODO" "WIP" "MAYBE" "|" "DONE" "WONT DO")))
  
  (org-startup-align-all-tables t)
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-pretty-entities t)

  ;; My export settings
  (org-html-checkbox-type 'html)
  (org-html-container-element "section")
  (org-html-divs
   '((preamble "div" "preamble")
     (content "article" "content")
     (postamble "div" "postamble")))
  (org-html-doctype "html5")
  (org-html-head "<link rel=\"stylesheet\" href=\"/assets/styles.css\" />")
  (org-html-head-include-default-style nil)
  (org-html-html5-fancy t)
  (org-html-indent nil)
  (org-html-postamble nil)

  (org-export-with-section-numbers nil)
  (org-export-with-toc nil)
  (org-export-preserve-breaks t)
  :config
  (if noninteractive
      (setq user-full-name "nes")
    (add-hook 'org-mode-hook 'my/writing-mode))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp t)
     (C t))))
     
;; Syntax Highlighting in HTML Export
;; [NOTE] Will interefere with exporting manually
(use-package htmlize
  :when noninteractive)

;; Better Bullets
(use-package org-superstar
  :after org
  :unless noninteractive
  :custom
  (org-superstar-headline-bullets-list '(42 42 42 32))
  (org-superstar-item-bullet-alist '((42 . 8226) (43 . 8226) (45 . 8226)))
  :hook (org-mode . org-superstar-mode))

(use-package markdown-mode
  :unless noninteractive
  :custom
  (markdown-display-remote-images t)
  (markdown-enable-highlighting-syntax t)
  (markdown-enable-math t)
  (markdown-hide-markup t)
  (markdown-hide-urls nil)
  (markdown-fontify-code-blocks-nativley t)
  :config
  (add-hook 'markdown-mode-hook 'my/writing-mode))

;; ====================
;; General Writing Setup
;; ====================

(defun my/add-visual-replacement (from to)
  " Does some black magic fuckery to allow prettify-symbols
    to use replacement strings of multiple chars.  "
  (push (cons from (let ((composition nil))
                     (dolist (char (string-to-list to)
                                   (nreverse (cdr composition)))
                       (push char composition)
                       (push '(Br . Bl) composition))))
        prettify-symbols-alist))

(defun my/setup-prettify-symbols ()
  (setq prettify-symbols-alist
        '(("#+begin_quote" . "❝")
          ("#+BEGIN_QUOTE" . "❝")
          ("#+end_quote" . "❞")
          ("#+END_QUOTE" . "❞")
          ("#+end_src" . ">")
          ("#+END_SRC" . ">")
          ("#+end_example" . ">")
          ("#+END_EXAMPLE" . ">")
          ("[X]" . "☒")
          ("[ ]" . "☐")))

  (my/add-visual-replacement "#+begin_src" "Source:")
  (my/add-visual-replacement "#+BEGIN_SRC" "Source:")

  (my/add-visual-replacement "#+begin_example" "Example:")
  (my/add-visual-replacement "#+BEGIN_EXMAPLE" "Example:")

  (my/add-visual-replacement "#+results:" "Results: ")
  (my/add-visual-replacement "#+RESULTS:" "Results: "))

(require 'modeline)

(unless noninteractive
  (use-package wc-mode
    :load-path "modules/extern"
    :after (org markdown-mode)
    :custom
    (wc-modeline-format "%tw Words")))

;; Cleanup stuff for org & markdown mode
(defun my/writing-mode ()
  (variable-pitch-mode 1)
  (flyspell-mode 1)

  ;; Turn off stuff
  (hl-line-mode -1)
  ;; I want to use this but it's a global setting ;-;
  ;; (show-paren-mode -1)
  (fringe-mode 0)
  (toggle-truncate-lines 1)
  (electric-indent-local-mode -1)

  (wc-mode 1)
  (my/mode-line-for-writing)
  (set-window-scroll-bars (minibuffer-window) 0 'none) ;; Fix scrollbars randomly showing up in writing-mode

  ;; Pretty symbols
  (my/setup-prettify-symbols)
  (prettify-symbols-mode 1)

  (when (equal major-mode 'markdown-mode)
    (markdown-display-inline-images))

  ;; Clear any messages
  (message ""))

(provide 'writing)
