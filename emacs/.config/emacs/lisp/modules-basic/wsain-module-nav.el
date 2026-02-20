(straight-use-package 'nerd-icons)

(straight-use-package 'nerd-icons-dired)
(with-eval-after-load 'nerd-icons-dired-autoloads
 (setq neo-show-hidden-file t)
 (add-hook 'dired-mode-hook 'nerd-icons-dired-mode))

;; use treemacs-add-and-display-current-project-exclusively
(straight-use-package 'treemacs)
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "j") 'treemacs-next-line)
  (define-key treemacs-mode-map (kbd "k") 'treemacs-previous-line))

(straight-use-package 'zoxide)

(provide 'wsain-module-nav)

