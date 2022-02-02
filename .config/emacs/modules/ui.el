(use-package vertico
  :config
  (vertico-mode))

(use-package neotree
  :bind ("C-c F" . neotree-toggle)
  :custom
  (neo-show-hidden-files t)
  (neo-smart-open t)
  (neo-theme 'icons))

;; Better terminal
(use-package vterm
  :bind ("C-c t" . vterm-other-window))

(use-package all-the-icons)

;; Fuzzy Finding
(use-package hotfuzz
  :custom
  (completion-styles '(hotfuzz)))

;; Find bookmarks, files, many other things
(use-package consult
 :after vertico
 :bind (("C-c f"  . consult-find)
        ("C-c b"  . consult-buffer)
        ("C-c B" . consult-bookmark)
        ("C-c if" . consult-grep)
        ("C-c man"  . consult-man))
 :custom
 (consult-find-args "find .")
 (consult-project-root-function
      (lambda ()
        (when-let (project (project-current))
          (car (project-roots project))))))


(provide 'ui)
