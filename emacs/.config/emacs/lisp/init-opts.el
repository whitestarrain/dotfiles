;;;===================================================
;;; USER INTERFACE & APPEARANCE
;;;===================================================

;; Font and Text Display
(set-face-attribute 'default nil :height 140)

;; Mouse Cursor
(set-mouse-color "White")

;; Cursor Behavior
(blink-cursor-mode -1)                    ; Disable cursor blinking
(column-number-mode t)                    ; Show column number in mode-line

;; Audio/Visual Feedback
(setq ring-bell-function 'ignore)         ; Disable bell sound

;; Bidirectional Text
(setq bidi-paragraph-direction 'left-to-right)

;; Display Performance
(setq redisplay-skip-fontification-on-input t)

;;;===================================================
;;; STARTUP & SHUTDOWN
;;;===================================================

;; Startup Screen and Messages
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-buffer-menu t)
(setq inhibit-default-init t)

;; Initial Scratch Buffer
(setq initial-scratch-message (concat ";; Happy hacking, "
                                      (capitalize user-login-name) " - Emacs ♥ you!\n\n"))

;; Exit Confirmation
(setq confirm-kill-emacs 'y-or-n-p)

;;;===================================================
;;; MOUSE & CLIPBOARD CONFIGURATION
;;;===================================================

;; Terminal Mouse Support
(xterm-mouse-mode 1)                      ; Enable mouse in terminal

;; Mouse Behavior
(setq mouse-yank-at-point t)              ; Middle-click yanks at point
(setq select-enable-primary nil)          ; Disable primary selection
(setq select-enable-clipboard t)          ; Sync with system clipboard

;;;===================================================
;;; SCROLLING & WINDOW BEHAVIOR
;;;===================================================

;; Vertical Scrolling
(setq scroll-step 3)
(setq scroll-margin 3)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq scroll-preserve-screen-position 'always)

;; Horizontal Scrolling
(setq hscroll-step 3)
(setq hscroll-margin 3)

;; Window Configuration
(setq auto-window-vscroll nil)
;; (setq split-width-threshold 1)           ; Default vertical split (commented)

;;;===================================================
;;; EDITING & TEXT HANDLING
;;;===================================================

;; Auto-pairing
(electric-pair-mode)

;; Line Wrapping
(setq-default fill-column 80)             ; Auto break line at column 80
;; (auto-fill-mode -1)                    ; Disable auto break line

;; Indentation
(setq-default indent-tabs-mode nil)       ; Use spaces, not tabs
(setq-default tab-width 4)                ; Tab width for display

;; Kill Ring
(setq kill-ring-max 200)                  ; Max items in kill ring
(setq kill-do-not-save-duplicates t)      ; Avoid duplicates in kill ring
;; Mark Ring
(setq mark-ring-max 32)                   ; Max items in mark ring
(setq global-mark-ring-max 32)            ; Max items in global mark ring
(delete-selection-mode 1)                 ; Inerting text whill delete region while mark is active

;; File Backup
(setq make-backup-files nil)              ; Disable backup files
(setq auto-save-default nil)              ; Disable auto-save

;;;===================================================
;;; FILE & BUFFER HANDLING
;;;===================================================

;; Large File Handling
(setq large-file-warning-threshold 100000000)  ; 100MB warning threshold

;; Binary File Display
(setq display-raw-bytes-as-hex t)         ; Show binary as hex

;; Path Configuration
(setq doc-view-cache-directory (expand-file-name ".doc-view-cache" wsain-dir))

;;;===================================================
;;; DIALOG & PROMPT CUSTOMIZATION
;;;===================================================

;; Dialog Box Behavior
(setq use-dialog-box nil)                 ; Disable GUI dialog boxes

;; Yes/No Prompt Customization
(setq original-y-or-n-p 'y-or-n-p)
(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))

(defun default-yes-sometimes (prompt)
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

(defalias 'yes-or-no-p 'default-yes-sometimes)
(defalias 'y-or-n-p 'default-yes-sometimes)

;;;===================================================
;;; SYSTEM & PERFORMANCE
;;;===================================================

;; Lisp Evaluation (commented out)
;; (setq max-lisp-eval-depth 1000)
;; (setq max-specpdl-size 2500)

;; Enable Disabled Commands
(put 'list-timers 'disabled nil)          ; Enable list-timers command
(put 'list-threads 'disabled nil)         ; Enable list-threads command

;;;===================================================

(provide 'init-opts)
