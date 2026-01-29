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


(provide 'wsain-module-ivy)
