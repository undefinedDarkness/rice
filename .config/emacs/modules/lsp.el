;; -*- lexical-binding: t; -*-

;; ==================
;; Completion Providers
;; ==================

(require 'modeline)

;; LSP Client
(use-package lsp-mode
  :custom

  ;; Rust analyzer
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-proc-macro-enable t)

  ;; Deno
  (lsp-clients-deno-enable-unstable t)

  (lsp-ui-doc-show-with-cursor nil)
  (lsp-completion-provider :none)
  (lsp-eldoc-enable-hover nil)
  (lsp-restart 'auto-restart)
  (lsp-headerline-breadcrumb-enable nil)
  
  :init
  (defun my/lsp-corfu-compat ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex))
    (my/mode-line-for-lsp))
  :commands lsp
  :hook ((rust-mode . lsp)
         (typescript-mode . lsp)
         (lsp-completion-mode . my/lsp-corfu-compat)))

;; Miscellaneous Completion Providers
(use-package cape
  :after corfu
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

;; =======================
;; Completion User Interface
;; =======================

(use-package corfu
             :custom
             (corfu-cycle t)
             (corfu-quit-no-match t)
             (corfu-auto t)
             :config
             (corfu-global-mode 1))

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t))

;; Show icons per type of completion item
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'lsp)
