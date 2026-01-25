(straight-use-package 'dashboard)
(setq dashboard-startup-banner 'logo)
(setq dashboard-banner-logo-title "Welcome to Emacs")
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-set-init-info t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq initial-buffer-choice (lambda() (get-buffer "*dashboard*")))
(setq dashboard-items '((recents   . 10)
                        (bookmarks . 5)
                        (projects  . 10)
                        (agenda    . 10)
                        (registers . 5)))
(with-eval-after-load 'dashboard-autoloads
    (dashboard-setup-startup-hook))


(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'wsain-module-ui)
