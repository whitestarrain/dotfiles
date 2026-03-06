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

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(provide 'init-functions)
