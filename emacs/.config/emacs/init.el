(defvar wsain-dir (file-name-directory load-file-name)
  "The root dir of the Emacs conf.")
(defvar wsain-lisp-dir (expand-file-name "lisp" wsain-dir)
  "The home of wsain's basic functionality.")

(add-to-list 'load-path wsain-lisp-dir)

;; basic config
(require 'init-opts)
(require 'init-mapping)
(require 'init-utils)
;; plugin manager
(require 'init-straight)
;; plugins
(require 'init-modules)

;; theme
(load-theme 'gruvbox-dark-medium t)

