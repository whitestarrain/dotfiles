(straight-use-package 'markdown-mode)
(add-hook 'markdown-mode-hook 'markdown-display-inline-images)
(setq markdown-max-image-size '(800 . 600))

(straight-use-package 'imenu-list)

(provide 'wsain-module-markdown)
