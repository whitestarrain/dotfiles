(straight-use-package 'ivy)
(straight-use-package 'marginalia)

(ivy-mode)
(marginalia-mode)

;; ivy fuzzy search
;; (with-eval-after-load 'ivy
;;   (push (cons #'swiper (cdr (assq t ivy-re-builders-alist)))
;;         ivy-re-builders-alist)
;;   (push (cons t #'ivy--regex-fuzzy) ivy-re-builders-alist))

(setopt ivy-use-virtual-buffers t)
(setopt enable-recursive-minibuffers t)

;; makes org-refile outline working with helm/ivy
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm) ; M-i to insert ivy current item

(straight-use-package 'ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-center)))
(setq ivy-posframe-parameters
      '((left-fringe . 16)
        (right-fringe . 16)
        (internal-border-width . 4)))
(ivy-posframe-mode 1)

(provide 'wsain-module-ivy)
