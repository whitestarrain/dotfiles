(straight-use-package 'org-mode)
(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)
                               (emacs-lisp . t)
                               (python . t)))

(straight-use-package 'org-download)

(with-eval-after-load 'org-download-autoloads
    (org-download-enable)
    (setq-default org-download-image-dir "./image"))

;; (straight-use-package 'org-tidy)
;; (add-hook 'org-mode-hook #'org-tidy-mode)

;; (straight-use-package 'org-modern)

(provide 'wsain-module-org)

