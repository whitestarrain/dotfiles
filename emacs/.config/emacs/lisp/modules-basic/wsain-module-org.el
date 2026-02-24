(straight-use-package 'org-mode)
(with-eval-after-load 'org-mode-autoloads
  ;; basic
  (setq org-startup-indented t)
  (setq org-indent-indentation-per-level 2)
  (org-babel-do-load-languages 'org-babel-load-languages
                              '((shell . t)
                                (emacs-lisp . t)
                                (python . t)))
  ;; todo (run org-mode-restart after using `#+TODO:`)
  (setq org-startup-folded 'fold)
  (setq org-enforce-todo-dependencies t)
  (setq org-log-into-drawer t)
  (setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(d!)" "WAIT(w@/!)" "|" "DONE(o!)")
        (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
        (sequence "|" "CANCELED(c@)")))

  ;; tag
  (setq org-tag-alist (setq org-tag-alist '((:startgrouptag)
                                                      ("SCENE")
                                                      (:grouptags)
                                                      ("@life" . ?l)
                                                      ("@study" . ?s)
                                                      ("@work" . ?w)
                                                      (:endgrouptag))))

  ;; agenda
  (make-directory "~/Agenda" t)
  (setq org-agenda-files '("~/Agenda"))
  (setq org-default-notes-file "~/Agenda/default.org"))

(straight-use-package 'org-download)
(with-eval-after-load 'org-download-autoloads
    (org-download-enable)
    (setq-default org-download-image-dir "./image"))

(straight-use-package 'org-ql)

;; (straight-use-package 'org-tidy)
;; (add-hook 'org-mode-hook #'org-tidy-mode)

;; (straight-use-package 'org-modern)

(provide 'wsain-module-org)

