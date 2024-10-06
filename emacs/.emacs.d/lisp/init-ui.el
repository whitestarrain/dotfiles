(setq use-dialog-box nil)
(setq inhibit-default-init t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-buffer-menu t)

(setq initial-scratch-message (concat ";; Happy hacking, "
                                      (capitalize user-login-name) " - Emacs ♥ you!\n\n"))

(setq bidi-paragraph-direction 'left-to-right)

(setq-default fill-column 80)

(setq large-file-warning-threshold 100000000)

(setq display-raw-bytes-as-hex t)

(setq redisplay-skip-fontification-on-input t)

(setq ring-bell-function 'ignore)

(blink-cursor-mode -1)

(setq mouse-yank-at-point t)

(setq select-enable-primary nil)
(setq select-enable-clipboard t)

(setq scroll-step 2)
(setq scroll-margin 2)
(setq hscroll-step 2)
(setq hscroll-margin 2)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq scroll-preserve-screen-position 'always)

(setq auto-window-vscroll nil)

(setq split-width-threshold (assoc-default 'width default-frame-alist))
(setq split-height-threshold nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq original-y-or-n-p 'y-or-n-p)
(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))
(defun default-yes-sometimes (prompt)
  "automatically say y when buffer name match following string"
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
(defalias 'yes-or-no-p 'default-yes-sometimes)
(defalias 'y-or-n-p 'default-yes-sometimes)

(setq kill-ring-max 200)

(setq kill-do-not-save-duplicates t)

(setq mark-ring-max 6)
(setq global-mark-ring-max 6)

(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)

(put 'list-timers 'disabled nil)
(put 'list-threads 'disabled nil)

(xterm-mouse-mode 1)

(setq confirm-kill-emacs 'y-or-n-p)

(column-number-mode t)

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(set-face-attribute 'default nil :height 140)

(when (display-graphic-p)
  (let ((top    (round (* (x-display-pixel-height) 0.125)))
        (left   (round (* (x-display-pixel-width) 0.125)))
        (height (round (* 0.75
                          (/ (x-display-pixel-height)
                             (frame-char-height))))))
    (let ((width  (round (* 0.75
                          (/ (x-display-pixel-width)
                             (frame-char-width))))))
      (setq default-frame-alist nil)
      (add-to-list 'default-frame-alist (cons 'top top))
      (add-to-list 'default-frame-alist (cons 'left left))
      (add-to-list 'default-frame-alist (cons 'height height))
      (add-to-list 'default-frame-alist (cons 'width width)))))

(provide 'init-ui)

