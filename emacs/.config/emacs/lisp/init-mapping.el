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

(global-set-key (kbd "M-]") 'move-point-half-page-down)
(global-set-key (kbd "M-[") 'move-point-half-page-up)

(provide 'init-mapping)
