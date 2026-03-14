;; remove some mapping
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-q") nil)
(global-set-key (kbd "C-x C-z") nil)

;; file
(global-set-key (kbd "C-x C-g") 'find-file-at-point)

;; edit
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "C-,") 'wsain/duplicate-line)

;; navigation
(global-set-key (kbd "C-c i m") 'imenu)

;; org
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; move
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
