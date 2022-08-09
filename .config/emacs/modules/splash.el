;; -*- lexical-binding: t; -*-
;; Splash Screen stolen & modified from sumibi

(defun my-splash/show ()
  (get-buffer-create "*splash*")
  (interactive)
  (with-current-buffer "*splash*"
    (erase-buffer)
    (setq header-line-format nil)
    (setq mode-line-format nil)
    (setq cursor-type nil)
    (setq line-spacing 0)
    (setq vertical-scroll-bar nil)
    (setq horizontal-scroll-bar nil)
    (face-remap-add-relative 'link :underline nil)
    (let* ((selected-img (expand-file-name "modules/bot.png" user-emacs-directory)))
      ;; top paddin g
      (insert-char ?\n 3)

      ;; center image horizontally with spaces
      (insert (propertize " " 'display
                          `(space :align-to (+ center (-0.5 . ,(create-image selected-img))))))
      (insert-image (create-image selected-img)))
    (insert-char ?\n 2)

    (let* ((splash-text (my-splash--show-text)))
      (insert (propertize " " 'display
                          `(space :align-to (+ center (-0.5 . ,(length splash-text))))))
      (insert splash-text))
    (insert "\n")

    ;;        ;;set read only mode
    (read-only-mode t)
    ;; jump to beginning of buffer
    (beginning-of-buffer)
    (goto-char 0)
    (local-set-key [t] 'my-splash--kill)))

(defun my-splash--show-text ()
  (propertize (emacs-init-time "Started in %.3f seconds") 'face '('shadow 'italic))) 

(defun my-splash--kill ()
  "Kill the splash screen buffer (immediately)."
  (interactive)
  (if (get-buffer "*splash*")
      (progn (message nil)
             (kill-buffer "*splash*"))))

(defun display-startup-echo-area-message ()
  (message " "))

(provide 'splash)
