(straight-use-package 'org-mode)
(with-eval-after-load 'org-mode-autoloads
  ;; BASIC
  (setq org-startup-indented t)
  (setq org-indent-indentation-per-level 1)
  (setq org-read-date-force-compatible-dates nil)
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((shell . t)
                                 (emacs-lisp . t)
                                 (python . t)))

  ;; TODO (run org-mode-restart after using `#+TODO:`)
  (setq org-startup-folded 'fold)
  (setq org-enforce-todo-dependencies t)
  (setq org-log-into-drawer t)
  (setq org-log-reschedule t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DOING(d@/!)""WAIT(w@/!)" "HOLD(h@/!)" "|" "DONE(o!)" "CANCELED(c@)")
          (sequence "INBOX(i)" "|" "CANCELED(c@)")
          (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")))
  (setq org-todo-keyword-faces
        '(("TODO" . (:background "#63d0d4" :foreground "#3c3836" :weight bold))
          ("DOING" . (:background "#63a0d5" :foreground "#3c3836" :weight bold))
          ("HOLD" . (:background "#d79921" :foreground "#3c3836" :weight bold))
          ("WAIT" . (:background "#fe8019" :foreground "#3c3836" :weight bold))
          ("DONE" . (:background "#8ec07c" :foreground "#3c3836" :weight bold))
          ("CANCELED" . (:background "#fb4934" :foreground "#3c3836" :weight bold :strike-through t))

          ("INBOX" . (:background "#fabd2f" :foreground "#3c3836" :weight bold))

          ("REPORT" . (:background "#d3869b" :foreground "#3c3836" :weight bold))
          ("BUG" . (:background "#fb4934" :foreground "#3c3836" :weight bold))
          ("KNOWNCAUSE" . (:background "#b16286" :foreground "#3c3836" :weight bold))
          ("FIXED" . (:background "#8ec07c" :foreground "#3c3836" :weight bold))))
  (setq org-modern-todo-faces org-todo-keyword-faces)

  ;; [/] [%A] statistic
  (setq org-hierarchical-todo-statistics nil) ; recursive statistics cookie count TODO entries

  ;; TAG
  (setq org-tag-alist (setq org-tag-alist '((:startgrouptag)
                                            ("SCENE")
                                            (:grouptags)
                                            ("@life" . ?l)
                                            ("@study" . ?s)
                                            ("@work" . ?w)
                                            (:endgrouptag))))

  ;; AGENDA
  (setq-default org-agenda-dir "~/Agenda")
  (make-directory org-agenda-dir t)
  (setq org-agenda-files (cons org-agenda-dir nil))
  (setq org-default-notes-file nil)
  (setq org-agenda-log-mode-items '(state clock))
  (setq org-agenda-clockreport-parameter-plist
              '(:link t
                :maxlevel 5
                :fileskip0 t
                :compact nil
                :narrow 80))
  ;; (setq org-agenda-skip-scheduled-if-done t)
  ;; (setq org-agenda-skip-deadline-if-done t)
  (setq org-log-note-clock-out t)
  (advice-add 'org-agenda-get-timestamps :override #'wsain/org-agenda-get-timestamps)

  ;; REFILE && ARCHIVE
  (setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3)))
  (setq org-archive-location "archive/%s_archive::")
  (setq org-archive-file-header-format nil)
  ;; https://emacs-china.org/t/todo/15701/9?u=wsain
  ;; (defun archive-done-tasks ()
  ;; (interactive)
  ;; (save-excursion
  ;;   (goto-char (point-min))
  ;;   (while (re-search-forward
  ;;           (concat "\\* " (regexp-opt org-done-keywords) " ") nil t)
  ;;     (goto-char (line-beginning-position))
  ;;     (org-archive-subtree))))
  ;; (add-to-list 'safe-local-variable-values '(after-save-hook . (archive-done-tasks)))

  ;; CAPTURE
  ;; TODO: journal defualt add tag 'journal', org-agenda default filter journal tag
  (setq org-capture-templates
        `(
          ("i"
           "Inbox"
           entry
           (file ,(expand-file-name "inbox.org" org-agenda-dir))
           "* INBOX %? %T \n %i")
          ("w"
           "Work_Journal"
           entry
           (file+olp+datetree ,(expand-file-name "work_journal.org" org-agenda-dir))
           "* %? %U \n %i")
          ("d"
           "Diary"
           entry
           (file+olp+datetree ,(expand-file-name "diary.org" org-agenda-dir))
           "* %? %U \n %i")
          ))

  (add-hook 'org-capture-before-finalize-hook
            (lambda ()
              (when (eq major-mode 'org-mode)
                (org-align-tags t))))

  ;; MAPPING
  (define-key org-mode-map (kbd "C-c C-t") nil)
  (define-key org-mode-map (kbd "C-c o") 'org-todo)
  (add-hook 'org-agenda-mode-hook
            (lambda ()
              (define-key org-agenda-mode-map "k" 'org-capture)
              (define-key org-agenda-mode-map "K" 'org-agenda-capture))))

(straight-use-package 'org-download)
(with-eval-after-load 'org-download-autoloads
  (org-download-enable)
  (setq-default org-download-image-dir "./image"))

(straight-use-package 'org-ql)

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


;; TODO: recurive search (directory-files-recursively), set org-id-extra-files
(straight-use-package '(org-super-links :type git :host github :repo "toshism/org-super-links"))
(with-eval-after-load 'org-super-links-autoloads
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  (define-key org-mode-map (kbd "C-c s l") 'org-super-links-link)
  (define-key org-mode-map (kbd "C-c s s") 'org-super-links-store-link)
  (define-key org-mode-map (kbd "C-c s i") 'org-super-links-insert-link))

;; (straight-use-package 'org-tidy)
;; (add-hook 'org-mode-hook #'org-tidy-mode)

(provide 'wsain-module-org)

