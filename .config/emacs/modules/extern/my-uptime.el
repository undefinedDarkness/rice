;; Super scuffed module to store uptime

(defvar my-past-uptime 0 "Uptime count before this session")
(defvar my-past-uptime-storage (expand-file-name "var/.uptime" user-emacs-directory) "Uptime storage location")

(defun my-uptime-save ()
  (let ((inhibit-message t)) (write-region
                              (number-to-string (+ (string-to-number (emacs-uptime "%s")) my-past-uptime))
                              nil
                              my-past-uptime-storage)))
  ;; (message "Updated uptime store"))


(defun my-uptime-load ()
 (setq my-past-uptime (string-to-number (with-temp-buffer
                                          (insert-file-contents (expand-file-name "var/.uptime" user-emacs-directory))
                                          (buffer-string)))))

(add-hook 'kill-emacs-hook 'my-uptime-save)
(run-with-idle-timer 60 1 'my-uptime-save)

(provide 'my-uptime)
