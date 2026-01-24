(straight-use-package 'org-mode)
(straight-use-package 'org-download)

(org-babel-do-load-languages 'org-babel-load-languages
    '(
        (shell . t)
        (emacs-lisp . t)
        (python . t)))
    


(provide 'wsain-module-org)

