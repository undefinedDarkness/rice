;; -*- lexical-binding: t; -*-

;; ==================
;; Completion Providers
;; ==================

;; LSP Client
(use-package eglot
  :hook (typescript-mode . eglot-ensure)
  :config
  (add-to-list 'completion-styles 'flex)
  (add-to-list 'eglot-server-programs '((js-mode typescript-mode) . (eglot-deno "/home/portal/.deno/bin/deno" "lsp")))

  (defclass eglot-deno (eglot-lsp-server) ()
    :documentation "A custom class for deno lsp.")

  (cl-defmethod eglot-initialization-options ((server eglot-deno))
    "Passes through required deno initialization options"
    (list :enable t
          :unstable t
          :lint t)))

;; Miscellaneous Completion Providers
(use-package cape
  :after corfu
  :config
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-hook 'org-mode-hook (lambda ()
                             (add-to-list 'completion-at-point-functions #'cape-ispell))))

;; =======================
;; Completion User Interface
;; =======================

(use-package corfu
             :custom
             (corfu-cycle t)
             (corfu-quit-no-match t)
             (corfu-auto t)
             :commands corfu-mode
             :hook ((eglot-server-initialized-hook . corfu-mode)
                    (emacs-lisp-mode . corfu-mode)))

;; Show icons per type of completion item
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'lsp)
