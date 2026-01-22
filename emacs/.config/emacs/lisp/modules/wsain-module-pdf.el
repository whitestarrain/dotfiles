(setq org-noter-always-create-frame nil)

(straight-use-package 'org-noter)
(straight-use-package 'pdf-tools)

;; `M-x describe-variable RET features RET` to get feature name
(with-eval-after-load 'pdf-tools-autoloads
    (pdf-tools-install)

    (add-hook 'pdf-view-mode-hook 'pdf-view-fit-height-to-window)
    (add-hook 'pdf-view-mode-hook 'pdf-view-roll-minor-mode)

    (require 'pdf-links)
    (require 'pdf-annot)
    (require 'pdf-history)
    (require 'pdf-view))

(add-to-list 'auto-mode-alist '("\\.[pP][dD][fF]\\'" . pdf-view-mode))
(add-to-list 'magic-mode-alist '("%PDF" . pdf-view-mode))

(provide 'wsain-module-pdf)
