(straight-use-package 'company-mode)
(with-eval-after-load 'company-mode-autoloads
  (setq company-idle-delay nil)
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-.") #'company-indent-or-complete-common)
  (global-set-key (kbd "M-/") #'xref-find-definitions))

(provide 'wsain-module-completion)
