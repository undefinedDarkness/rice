;; -*- lexical-binding: t; -*-

;; (setq custom-mode-line-right '("" mode-line-modes))

;; (defun custom-mode-line/separator ()
;;   (let ((r-length (length (format-mode-line custom-mode-line-right))))
;;     (propertize " "
;;                 'display `(space :align-to (- (+ right right-fringe right-margin) ,r-length)))))

;; (setq-default mode-line-format
;;               '(""
;;                 (:eval (custom-mode-line/separator))
;;                 mode-line-modes))

(setq-default mode-line-format "%-")
(provide 'modeline)
