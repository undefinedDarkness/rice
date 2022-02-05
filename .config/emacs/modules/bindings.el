;; -*- lexical-binding: t; -*-

;; Make escape auto quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Save File
(global-set-key [f3] 'save-buffer)

;; Update File Contents
(global-set-key [f5] (lambda () (interactive)
                                (revert-buffer :noconfirm :ignore-auto)))

;; Comment Region
(define-key evil-normal-state-map (kbd "gc") 'comment-line)

(provide 'bindings)
