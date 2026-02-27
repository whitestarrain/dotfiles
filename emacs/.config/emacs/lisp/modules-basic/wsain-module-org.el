(straight-use-package 'org-mode)
(with-eval-after-load 'org-mode-autoloads
  ;; basic
  (setq org-startup-indented t)
  (setq org-indent-indentation-per-level 2)
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((shell . t)
                                 (emacs-lisp . t)
                                 (python . t)))

  ;; TODO: style (https://sophiebos.io/posts/beautifying-emacs-org-mode/)

  ;; todo (run org-mode-restart after using `#+TODO:`)
  (setq org-startup-folded 'fold)
  (setq org-enforce-todo-dependencies t)
  (setq org-log-into-drawer t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(d!)" "WAIT(w@/!)" "|" "DONE(o!)" "CANCELED(c@)")
          (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")))

  ;; tag
  (setq org-tag-alist (setq org-tag-alist '((:startgrouptag)
                                            ("SCENE")
                                            (:grouptags)
                                            ("@life" . ?l)
                                            ("@study" . ?s)
                                            ("@work" . ?w)
                                            (:endgrouptag)
                                            ("journal"))))

  ;; agenda
  (setq-default org-agenda-dir "~/Agenda")
  (make-directory org-agenda-dir t)
  (setq org-agenda-files (cons org-agenda-dir nil))
  (setq org-default-notes-file nil)

  ;; capture
  ;; TODO: journal defualt add tag 'journal', org-agenda default filter journal tag
  (setq org-capture-templates
        `(
          ("i"
           "Inbox"
           entry
           (file ,(expand-file-name "inbox.org" org-agenda-dir))
           "* TODO %? %U \n %i")
          ("j"
           "Journal"
           entry
           (file+olp+datetree ,(expand-file-name "journal.org" org-agenda-dir))
           "* %? %T \n %i")
          ))

  ;; mapping
  (define-key org-mode-map (kbd "C-c C-t") nil)
  (define-key org-mode-map (kbd "C-c o") 'org-todo))

(straight-use-package 'org-download)
(with-eval-after-load 'org-download-autoloads
  (org-download-enable)
  (setq-default org-download-image-dir "./image"))

(straight-use-package 'org-ql)

;; (straight-use-package 'org-tidy)
;; (add-hook 'org-mode-hook #'org-tidy-mode)

;; org-inhibit-startup can break org-modern's indent, such like function 'org-toggle-tags-groups
(straight-use-package 'org-modern)
(with-eval-after-load 'org-modern-autoloads
  (global-org-modern-mode)
  (setq org-modern-star '("◉" "○" "◈" "◇" "▸" "▹"))
  (unless window-system
    (setq org-modern-table nil)))

(straight-use-package '(org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent"))
(with-eval-after-load 'org-modern-indent-autoloads
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(provide 'wsain-module-org)

