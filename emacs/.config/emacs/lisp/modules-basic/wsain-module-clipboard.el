;; support OSC
(straight-use-package 'clipetty)
(with-eval-after-load 'clipetty-autoloads
  (global-set-key (kbd "M-w") 'clipetty-kill-ring-save))

(provide 'wsain-module-clipboard)

