;; -*- lexical-binding: t; -*-

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-agenda-files '("~/Documents/todo.org"))
  (org-src-tab-acts-natively t)

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
  :config
  (if noninteractive
      (setq user-full-name "nes")
      (add-hook 'org-mode-hook 'my/writing-mode))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp t)
     (C t))))

;; Syntax Highlighting in HTML Export
(use-package htmlize
  :after org)

;; Better Bullets
(use-package org-superstar
  :after org
  :unless noninteractive
  :custom
  (org-superstar-headline-bullets-list '(10240 42 10240 10240))
  (org-superstar-item-bullet-alist '((42 . 8226) (43 . 8226) (45 . 8226)))
  :hook (org-mode . org-superstar-mode))

;; Drag & Drop Support
(use-package org-download
  :after org
  :unless noninteractive
  :custom
  (org-download-method 'attach)) 

;; (use-package flyspell-correct
  ;; :after flyspell
  ;; :bind (:map flyspell-mode-map ("C-=" . flyspell-correct-wrapper)))

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
     

;; (use-package perfect-margin
;;   :commands perfect-margin-mode)

;; General Setup For Both Markdown & Org Mode

(defun my/add-visual-replacement (from to)
  " Does some black magic fuckery to allow prettify-symbols
    to use replacement strings of multiple chars.  "
   (push (cons from (let ((composition nil))
                      (dolist (char (string-to-list to)
                                    (nreverse (cdr composition)))
                        (push char composition)
                        (push '(Br . Bl) composition))))
         prettify-symbols-alist))

(setq prettify-symbols-alist
    '(("#+begin_quote" . "❝")
      ("#+BEGIN_QUOTE" . "❝")
      ("#+end_quote" . "❞")
      ("#+END_QUOTE" . "❞")
      ("#+end_src" . ">")
      ("#+END_SRC" . ">")
      ("#+end_example" . ">")
      ("#+END_EXAMPLE" . ">")))

;; [TODO] Add symbols for TODO

(my/add-visual-replacement "#+begin_src" "Source:")
(my/add-visual-replacement "#+BEGIN_SRC" "Source:")

(my/add-visual-replacement "#+begin_example" "Example:")
(my/add-visual-replacement "#+BEGIN_EXMAPLE" "Example:")

(my/add-visual-replacement "#+results:" "Results: ")
(my/add-visual-replacement "#+RESULTS:" "Results: ")

;; Cleanup stuff for org & markdown mode
(defun my/writing-mode ()
  (variable-pitch-mode 1)
  (fringe-mode 0)
  (toggle-truncate-lines 1)
  (flyspell-mode 1)
  (hl-line-mode -1)
  (electric-indent-local-mode -1)
  (prettify-symbols-mode 1)
  (when (equal major-mode 'markdown-mode)
      (markdown-display-inline-images))
  (message ""))

(provide 'writing)
