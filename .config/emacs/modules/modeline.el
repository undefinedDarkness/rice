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
  (setq mode-line-format (list (my/mode-line--right-align 13) '(:eval wc-buffer-stats))))

(provide 'modeline)
