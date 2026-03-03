(setq package-enable-at-startup nil)
(setq package-quickstart nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq frame-inhibit-implied-resize t)
;; make emacs work well with tiling window managers
(setq frame-resize-pixelwise t)

(dolist (func '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (if (functionp func)
      (funcall func -1)))

(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(provide 'early-init)

