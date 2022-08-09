;; Vertical list to select completion items (M-x)  
(use-package vertico
  :config
  (vertico-mode))

;; File Tree
(use-package neotree
  :defer t
  :config
  (add-hook 'neotree-mode-hook (lambda () (variable-pitch-mode)))
  :custom
  (neo-window-width 20)
  (neo-show-hidden-files t)
  (neo-smart-open t)
  (neo-theme 'icons)
  (neo-mode-line-type 'custom)
  (neo-hide-cursor t) ;; Does not work in evil mode ;-;
  (neo-mode-line-custom-format (list '(:eval neo-buffer--start-node))))

(defun my/neotree-project-dir-toggle ()
  "Open NeoTree using the project root, using projectile, find-file-in-project,
or the current buffer directory."
  (interactive)
  (require 'neotree)
  (let* ((filepath (buffer-file-name))
         (project-dir
          (with-demoted-errors
              (cond
               ((featurep 'projectile)
                (projectile-project-root))
               ((featurep 'find-file-in-project)
                (ffip-project-root))
               (t ;; Fall back to version control root.
                (if filepath
                    (vc-call-backend
                     (vc-responsible-backend filepath) 'root filepath)
                  nil)))))
         (neo-smart-open t))

    (if (and (fboundp 'neo-global--window-exists-p)
             (neo-global--window-exists-p))
        (neotree-hide)
      (neotree-show)
      (when project-dir
        (neotree-dir project-dir))
      (when filepath
        (neotree-find filepath)))))
(global-set-key (kbd "C-c F") 'my/neotree-project-dir-toggle)

;; Slight improvements to the neotree look
(use-package doom-themes-ext-neotree
  :after neotree
  :custom
  (doom-themes-neotree-file-icons t)
  :load-path "modules/extern")
  
;; Better terminal
(use-package vterm
  :config
  (defun my/split-with-vterm ()
    (interactive)
    (split-window-below)
    (vterm-other-window))
  (add-hook 'vterm-exit-functions (lambda (_ _)
                                    (when (not (one-window-p))
                                      (delete-window (get-buffer-window (current-buffer))))))
  (bind-key "C-c t" 'my/split-with-vterm))
  

(use-package all-the-icons)

(require 'appearance)

(provide 'ui)
