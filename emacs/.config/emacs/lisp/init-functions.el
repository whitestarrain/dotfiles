;; Yes/No Prompt Customization
(setq original-y-or-n-p 'y-or-n-p)
(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))
(defun wsain/default-yes-sometimes (prompt)
  "Automatically say 'yes' when prompt matches certain patterns"
  (if (or
       (string-match "has a running process" prompt)
       (string-match "does not exist; create" prompt)
       (string-match "modified; kill anyway" prompt)
       (string-match "Delete buffer using" prompt)
       (string-match "Kill buffer of" prompt)
       (string-match "still connected.  Kill it?" prompt)
       (string-match "Shutdown the client's kernel" prompt)
       (string-match "kill them and exit anyway" prompt)
       (string-match "Revert buffer from file" prompt)
       (string-match "Kill Dired buffer of" prompt)
       (string-match "delete buffer using" prompt)
       (string-match "Kill all pass entry" prompt)
       (string-match "for all cursors" prompt)
       (string-match "Do you want edit the entry" prompt))
      t
    (original-y-or-n-p prompt)))

(defun wsain/org-in-drawer-p ()
  "Return non-nil if point is inside an Org mode drawer.
This includes both regular drawers and property drawers."
  (let ((element (org-element-at-point)))
    (while (and element
                (not (memq (org-element-type element)
                           '(drawer property-drawer))))
      (setq element (org-element-property :parent element)))
    (when element
      t)))

(defun wsain/org-agenda-get-timestamps (&optional deadlines)
  "Return the date stamp information for agenda display.
Optional argument DEADLINES is a list of deadline items to be
displayed in agenda view."
  (with-no-warnings (defvar date))
  (let* ((props (list 'face 'org-agenda-calendar-event
		              'org-not-done-regexp org-not-done-regexp
		              'org-todo-regexp org-todo-regexp
		              'org-complex-heading-regexp org-complex-heading-regexp
		              'mouse-face 'highlight
		              'help-echo
		              (format "mouse-2 or RET jump to Org file %s"
			                  (abbreviate-file-name buffer-file-name))))
	     (current (calendar-absolute-from-gregorian date))
	     (today (org-today))
	     (deadline-position-alist
	      (mapcar (lambda (d)
		            (let ((m (get-text-property 0 'org-hd-marker d)))
		              (and m (marker-position m))))
		          deadlines))
	     ;; Match timestamps set to current date, timestamps with
	     ;; a repeater, and S-exp timestamps.
	     (regexp
	      (concat
	       (if org-agenda-include-inactive-timestamps "[[<]" "<")
	       (regexp-quote
	        (format-time-string
             "%Y-%m-%d" ; We do not use `org-time-stamp-format' to not demand day name in timestamps.
	         (org-encode-time	; DATE bound by calendar
	          0 0 0 (nth 1 date) (car date) (nth 2 date))))
	       "\\|\\(<[0-9]+-[0-9]+-[0-9]+[^>\n]+?\\+[0-9]+[hdwmy]>\\)"
	       "\\|\\(<%%\\(([^>\n]+)\\)\\([^\n>]*\\)>\\)"))
	     timestamp-items)
    (goto-char (point-min))
    (while (re-search-forward regexp nil t)
      ;; Skip date ranges, scheduled and deadlines, which are handled
      ;; specially.  Also skip timestamps before first headline as
      ;; there would be no entry to add to the agenda.  Eventually,
      ;; ignore clock entries.
      (catch :skip
	    (save-match-data
	      (when (or (org-at-date-range-p t)
		            (org-at-planning-p)
		            (org-before-first-heading-p)
		            (and org-agenda-include-inactive-timestamps
			             (org-at-clock-log-p))
                    (not (org-at-timestamp-p 'agenda))
                    ;; patch !!
                    (wsain/org-in-drawer-p)
                    )
	        (throw :skip nil))
	      (org-agenda-skip (org-element-at-point)))
	    (let* ((pos (match-beginning 0))
	           (repeat (match-string 1))
	           (sexp-entry (match-string 3))
	           (timestamp (if (or repeat sexp-entry) (match-string 0)
			                (save-excursion
			                  (goto-char pos)
			                  (looking-at org-ts-regexp-both)
			                  (match-string 0))))
	           (todo-state (org-get-todo-state))
	           (warntime (org-entry-get (point) "APPT_WARNTIME" 'selective))
	           (done? (member todo-state org-done-keywords)))
	      ;; Possibly skip done tasks.
	      (when (and done? org-agenda-skip-timestamp-if-done)
	        (throw :skip t))
	      ;; S-exp entry doesn't match current day: skip it.
	      (when (and sexp-entry (not (org-diary-sexp-entry sexp-entry "" date)))
	        (throw :skip nil))
	      (when repeat
	        (let* ((past
		            ;; A repeating time stamp is shown at its base
		            ;; date and every repeated date up to TODAY.  If
		            ;; `org-agenda-prefer-last-repeat' is non-nil,
		            ;; however, only the last repeat before today
		            ;; (inclusive) is shown.
		            (org-agenda--timestamp-to-absolute
		             repeat
		             (if (or (> current today)
			                 (eq org-agenda-prefer-last-repeat t)
			                 (member todo-state org-agenda-prefer-last-repeat))
			             today
		               current)
		             'past (current-buffer) pos))
		           (future
		            ;;  Display every repeated date past TODAY
		            ;;  (exclusive) unless
		            ;;  `org-agenda-show-future-repeats' is nil.  If
		            ;;  this variable is set to `next', only display
		            ;;  the first repeated date after TODAY
		            ;;  (exclusive).
		            (cond
		             ((<= current today) past)
		             ((not org-agenda-show-future-repeats) past)
		             (t
		              (let ((base (if (eq org-agenda-show-future-repeats 'next)
				                      (1+ today)
				                    current)))
			            (org-agenda--timestamp-to-absolute
			             repeat base 'future (current-buffer) pos))))))
	          (when (and (/= current past) (/= current future))
		        (throw :skip nil))))
	      (save-excursion
	        (re-search-backward org-outline-regexp-bol nil t)
	        ;; Possibly skip timestamp when a deadline is set.
	        (when (and org-agenda-skip-timestamp-if-deadline-is-shown
		               (assq (point) deadline-position-alist))
	          (throw :skip nil))
	        (let* ((category (org-get-category pos))
                   (effort (org-entry-get pos org-effort-property))
                   (effort-minutes (when effort (save-match-data (org-duration-to-minutes effort))))
		           (inherited-tags
		            (or (eq org-agenda-show-inherited-tags 'always)
			            (and (consp org-agenda-show-inherited-tags)
			                 (memq 'agenda org-agenda-show-inherited-tags))
			            (and (eq org-agenda-show-inherited-tags t)
			                 (or (eq org-agenda-use-tag-inheritance t)
				                 (memq 'agenda
				                       org-agenda-use-tag-inheritance)))))
		           (tags (org-get-tags nil (not inherited-tags)))
		           (level (make-string (org-reduced-level (org-outline-level))
				                       ?\s))
		           (head (and (looking-at "\\*+[ \t]+\\(.*\\)")
			                  (match-string 1)))
		           (inactive? (= (char-after pos) ?\[))
		           (habit? (and (fboundp 'org-is-habit-p) (org-is-habit-p)))
		           (item
		            (org-agenda-format-item
		             (and inactive? org-agenda-inactive-leader)
                     (org-add-props head nil
                       'effort effort
                       'effort-minutes effort-minutes)
                     level category tags timestamp org-ts-regexp habit?)))
	          (org-add-props item props
		        'urgency (if habit?
                             (org-habit-get-urgency (org-habit-parse-todo))
			               (org-get-priority item))
                'priority (org-get-priority item)
		        'org-marker (org-agenda-new-marker pos)
		        'org-hd-marker (org-agenda-new-marker)
		        'date date
		        'level level
                'effort effort 'effort-minutes effort-minutes
		        'ts-date (if repeat (org-agenda--timestamp-to-absolute repeat)
			               current)
		        'todo-state todo-state
		        'warntime warntime
		        'type "timestamp")
	          (push item timestamp-items))))
	    (when org-agenda-skip-additional-timestamps-same-entry
	      (outline-next-heading))))
    (nreverse timestamp-items)))


(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(provide 'init-functions)
