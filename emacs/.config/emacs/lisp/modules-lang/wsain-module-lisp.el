(setq parinfer-rust-auto-download t)
(straight-use-package 'parinfer-rust-mode)

(add-hook 'emacs-lisp-mode-hook (lambda()
                                 (message "enter emacs-lisp-mode")
                                 (electric-pair-mode -1)
                                 (parinfer-rust-mode)))

(add-hook 'lisp-interaction-mode-hook (lambda()
                                       (message "enter emacs-lisp-mode")
                                       (electric-pair-mode -1)
                                       (parinfer-rust-mode)))


(provide 'wsain-module-lisp)
