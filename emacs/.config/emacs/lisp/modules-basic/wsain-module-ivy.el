(straight-use-package 'ivy)

(ivy-mode)

;; ivy fuzzy search
;; (with-eval-after-load 'ivy
;;   (push (cons #'swiper (cdr (assq t ivy-re-builders-alist)))
;;         ivy-re-builders-alist)
;;   (push (cons t #'ivy--regex-fuzzy) ivy-re-builders-alist))

;; (setopt ivy-use-virtual-buffers t)
;; (setopt enable-recursive-minibuffers t)
;; ;; Enable this if you want `swiper' to use it:
;; ;; (setopt search-default-mode #'char-fold-to-regexp)
;; (keymap-global-set "C-s" #'swiper-isearch)
;; (keymap-global-set "C-c C-r" #'ivy-resume)
;; (keymap-global-set "<f6>" #'ivy-resume)
;; (keymap-global-set "M-x" #'counsel-M-x)
;; (keymap-global-set "C-x C-f" #'counsel-find-file)
;; (keymap-global-set "<f1> f" #'counsel-describe-function)
;; (keymap-global-set "<f1> v" #'counsel-describe-variable)
;; (keymap-global-set "<f1> o" #'counsel-describe-symbol)
;; (keymap-global-set "<f1> l" #'counsel-find-library)
;; (keymap-global-set "<f2> i" #'counsel-info-lookup-symbol)
;; (keymap-global-set "<f2> u" #'counsel-unicode-char)
;; (keymap-global-set "C-c g" #'counsel-git)
;; (keymap-global-set "C-c j" #'counsel-git-grep)
;; (keymap-global-set "C-c k" #'counsel-ag)
;; (keymap-global-set "C-x l" #'counsel-locate)
;; (keymap-global-set "C-S-o" #'counsel-rhythmbox)
;; (keymap-set minibuffer-local-map "C-r" #'counsel-minibuffer-history)



(provide 'wsain-module-ivy)
