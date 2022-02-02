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

(use-package typescript-mode
  :mode "\\.ts\\'")

(use-package highlight-defined
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; Ease Of Use
(use-package parinfer-rust-mode
  :hook (emacs-lisp-mode . parinfer-rust-mode)
  :config
  (indent-tabs-mode -1)) ;; parinfer chokes on tabs

(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))


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
      

;; Completion / Linting
(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; (add-hook 'prog-mode-hook (lambda () (flyspell-prog-mode)))

(provide 'programming)
