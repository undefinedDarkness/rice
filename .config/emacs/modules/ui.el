;; Vertical list to select completion items (M-x)  
(use-package vertico
  :config
  (vertico-mode))

;; File Tree
(use-package neotree
  :bind ("C-c F" . neotree-toggle)
  :config
  (add-hook 'neotree-mode-hook (lambda () (variable-pitch-mode)))
  :custom
  (neo-show-hidden-files t)
  (neo-smart-open t)
  (neo-theme 'icons)
  (neo-mode-line-type 'custom)
  (neo-hide-cursor t) ;; Does not work in evil mode ;-;
  (neo-mode-line-custom-format (list '(:eval neo-buffer--start-node))))

;; Slight improvements to the neotree look
(use-package doom-themes-ext-neotree
  :after neotree
  :custom
  (doom-themes-neotree-file-icons t)
  :load-path "modules/extern")
  
;; Better terminal
(use-package vterm
  :bind ("C-c t" . vterm-other-window))

(use-package all-the-icons)

(require 'appearance)

(provide 'ui)
