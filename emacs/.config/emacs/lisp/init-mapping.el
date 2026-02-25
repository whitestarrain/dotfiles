(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-q") nil)
;; (global-set-key (kbd "M-z") nil)
;; (global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)

(global-set-key (kbd "C-x C-g") 'find-file-at-point)
(global-set-key (kbd "C-c i m") 'imenu)

(global-set-key (kbd "M-j") 'join-line)

(defun move-point-half-page-down ()
  "scroll down half the page"
  (interactive)
  (next-line (/ (window-body-height) 2)))

(defun move-point-half-page-up ()
  "scroll up half the page"
  (interactive)
  (previous-line (/ (window-body-height) 2)))

(global-set-key (kbd "M-p") 'move-point-half-page-up)
(global-set-key (kbd "M-n") 'move-point-half-page-down)

;; terminal emacs, shift-tab
;; https://stackoverflow.com/questions/3518846/shift-tab-produces-cryptic-error-in-emacs
(add-hook 'term-setup-hook
          (lambda () (define-key input-decode-map "\e[Z" [backtab])))

(provide 'init-mapping)
