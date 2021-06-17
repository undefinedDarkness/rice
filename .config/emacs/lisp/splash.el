;; Splash Screen

(defun show-splash ()
  (get-buffer-create "*splash*")
  (interactive)
  (with-current-buffer "*splash*"
	(erase-buffer)

    (setq cursor-type nil)
    (setq line-spacing 0)
    (setq vertical-scroll-bar nil)
    (setq horizontal-scroll-bar nil)

	(let* ((selected-img (expand-file-name "./emma.png" user-emacs-directory)))

	;; top padding
	(insert-char ?\n 5)

	;; center image horizontally with spaces
    (insert (propertize " " 'display
     	`(space :align-to (+ center (-0.5 . ,(create-image selected-img))))))
    (insert-image (create-image selected-img)))
	(insert-char ?\n 3)

	(let* ((splash-text (init-time)))
	  (insert (propertize " " 'display
    		  `(space :align-to (+ center (-0.5 . ,(length splash-text))))))
	(insert splash-text))
	(insert "\n\n")

	(dolist (line (split-string (shell-command-to-string "fortune -sa") "\n"))
		(insert (propertize " " 'display
    					`(space :align-to (+ center (-0.5 . ,(length (string-trim line)))))))
		(insert (string-trim line))
		(insert "\n"))	

	;;set read only mode
	(read-only-mode t)
	;; jump to beginning of buffer
	(beginning-of-buffer)))

(defun init-time ()
  "Provide Message for splash text."
  (propertize (format "Started in %s with %d garbage collections." (emacs-init-time) gcs-done) 'face 'italic))

(provide 'Splash)
