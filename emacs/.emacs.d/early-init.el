(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

(setq package-enable-at-startup nil)
(setq package-quickstart nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq frame-inhibit-implied-resize t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(setq comp-deferred-compilation nil)

(provide 'early-init)

