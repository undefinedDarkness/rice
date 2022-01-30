
(defvar my-past-uptime 0 "Uptime count before this session")

(defun my-uptime-save ()
  (write-region
   (number-to-string (+ (string-to-number (emacs-uptime "%s")) my-past-uptime))
   nil
   (expand-file-name "var/.uptime" user-emacs-directory))
  (message "Updated uptime store"))


(defun my-uptime-load ()
 (setq my-past-uptime (string-to-number (with-temp-buffer
                                          (insert-file-contents (expand-file-name "var/.uptime" user-emacs-directory))
                                          (buffer-string)))))

(add-hook 'kill-emacs-hook 'my-uptime-save)
(run-with-idle-timer 60 1 'my-uptime-save)

(provide 'my-uptime)
