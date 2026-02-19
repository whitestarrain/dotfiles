(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "s-q") nil)
;; (global-set-key (kbd "M-z") nil)
;; (global-set-key (kbd "M-m") nil)
(global-set-key (kbd "C-x C-z") nil)

(global-set-key (kbd "C-x C-g") 'find-file-at-point)
(global-set-key (kbd "C-c i m") 'imenu)

(global-set-key (kbd "M-j") 'join-line)

(defun scroll-half-page-down ()
  "scroll down half the page"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))

(defun scroll-half-page-up ()
  "scroll up half the page"
  (interactive)
  (scroll-up (/ (window-body-height) 2)))

(global-set-key (kbd "M-]") 'scroll-half-page-up)
(global-set-key (kbd "M-[") 'scroll-half-page-down)

(provide 'init-mapping)
