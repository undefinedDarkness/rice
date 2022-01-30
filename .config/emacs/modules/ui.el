(use-package vertico
  :config
  (vertico-mode))


(use-package neotree
  :bind ("C-c F" . neotree-toggle)
  :custom
  (neo-show-hidden-files t)
  (neo-smart-open t)
  (neo-theme 'icons))

(use-package vterm
  :bind ("C-c t" . vterm-other-window))

(provide 'ui)
