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

(defun wsain/org-noter-set-highlight (&rest _arg)
    "Highlight current org-noter note."
    (save-excursion
      (with-current-buffer (org-noter--session-notes-buffer org-noter--session)
        (remove-overlays (point-min) (point-max) 'org-noter-current-hl t)
        (goto-char (org-entry-beginning-position))
        (let* ((hl (org-element-context))
               (hl-begin (plist-get  (plist-get hl 'headline) :begin))
               (hl-end (1- (plist-get  (plist-get hl 'headline) :contents-begin)))
               (hl-ov (make-overlay hl-begin hl-end)))
          (overlay-put hl-ov 'face 'mindre-keyword)
          (overlay-put hl-ov 'org-noter-current-hl t))
        (org-cycle-hide-drawers 'all))))

(advice-add #'org-noter--focus-notes-region
            :after #'eli/org-noter-set-highlight)
(advice-add #'org-noter-insert-note
            :after #'eli/org-noter-set-highlight)

(provide 'wsain-module-pdf)
