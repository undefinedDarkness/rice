;; -*- lexical-binding: t; -*-

(use-package lua-mode
  :mode "\\.lua\\'"
  :custom
  (lua-indent-nested-block-content-align nil)
  (lua-indent-close-paren-align nil)
  (lua-indent-level 2)
  :config
  (defun lua-at-most-one-indent (old-function &rest arguments)
    (let ((old-res (apply old-function arguments)))
      (if (> old-res lua-indent-level) lua-indent-level old-res)))

  (advice-add #'lua-calculate-indentation-block-modifier
              :around #'lua-at-most-one-indent))
 
(use-package highlight-defined
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; Ease Of Use
(use-package parinfer-rust-mode
  :hook (emacs-lisp-mode . parinfer-rust-mode)
  :config
  (indent-tabs-mode -1)) ;; parinfer chokes on tabs

(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

(use-package hotfuzz
  :custom
  (completion-styles '(hotfuzz)))

(use-package origami
  :after evil
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (setq-local origami-fold-style 'triple-braces)
                              (origami-mode)
                              (origami-close-all-nodes (current-buffer))))
  (defun my/origami-toggle-node ()
    (interactive)
    (save-excursion
      (goto-char (point-at-eol))
      (origami-toggle-node (current-buffer) (point))))
  (evil-define-key 'normal prog-mode-map (kbd "TAB") 'my/origami-toggle-node))
      

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

(provide 'programming)
