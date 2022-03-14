;; ===============
;; Helper Functions
;; ===============

(defun my/mode-line--right-align (reserve)
 "Return empty space using FACE and leaving RESERVE space on the right."
 (when
   (and window-system (eq 'right (get-scroll-bar-mode)))
   (setq reserve (- reserve 3)))
 (propertize " "
   'display
   `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))))

;; =================
;; Mode Line Variants
;; =================

(defun my/mode-line-for-writing ()
  (setq mode-line-format (list '(:eval (substring-no-properties (org-display-outline-path nil t " > " t)) (my/mode-line--right-align 13) '(:eval wc-buffer-stats)))))

(defun my/mode-line-for-lsp ()
  (lsp-headerline-breadcrumb-mode -1)
  (setq mode-line-format (list '(:eval (substring-no-properties (lsp-headerline--build-string))))))
  

(provide 'modeline)
