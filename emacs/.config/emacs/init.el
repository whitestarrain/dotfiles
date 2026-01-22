(defvar wsain-dir (file-name-directory load-file-name)
  "The root dir of the Emacs conf.")
(defvar wsain-lisp-dir (expand-file-name "lisp" wsain-dir)
  "The home of wsain's basic functionality.")
(defvar wsain-modules-dir (expand-file-name "modules" wsain-lisp-dir)
  "The home of wsain's module configs.")
(defvar wsain-themes-dir (expand-file-name "custom-themes" wsain-lisp-dir)
  "The home of wsain's themes.")

(setq doc-view-cache-directory (expand-file-name ".doc-view-cache" wsain-dir))

(add-to-list 'load-path wsain-lisp-dir)
(add-to-list 'load-path wsain-modules-dir)
(add-to-list 'custom-theme-load-path wsain-themes-dir)

(require 'init-ui)
(require 'init-edit)
(require 'init-straight)
(require 'init-modules)

;; theme
(load-theme 'gruvbox-dark-medium t)

