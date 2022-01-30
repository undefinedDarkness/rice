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
   (let* ((selected-img (expand-file-name "modules/splash.png" user-emacs-directory)))
           ;; top paddin g
         (insert-char ?\n 8)

           ;; center image horizontally with spaces
       (insert (propertize " " 'display
                                             `(space :align-to (+ center (-0.5 . ,(create-image selected-img))))))
       (insert-image (create-image selected-img)))
   (insert-char ?\n 3)

   (let* ((splash-lines (split-string (my-splash--show-text) "\n")))
     (dolist (line splash-lines)
      (insert (propertize " " 'display
                          `(space :align-to (+ center (-0.5 . ,(length line))))))
      (insert line)
      (insert "\n")))
          ;;set read only mode
   (read-only-mode t)
        ;; jump to beginning of buffer
   (beginning-of-buffer)
   (goto-char 0)
   (local-set-key [t] 'my-splash--kill)))

(require 'my-uptime)
(defun my-splash--show-text ()
  (my-uptime-load)
  (format-seconds "%D %H %M %z%S" my-past-uptime))

(defun my-splash--kill ()
  "Kill the splash screen buffer (immediately)."
  (interactive)
  (if (get-buffer "*splash*")
      (progn (message nil)
             (kill-buffer "*splash*"))))

(defun display-startup-echo-area-message ()
  (message " "))

(provide 'splash)
